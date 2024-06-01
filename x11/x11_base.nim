# import system/ctypes
#[
  Requires
    sudo apt-get install libx11-dev
  Compile with
    nim c --run --passL:"-lX11" test_uinput.nim
]#
type Display*  {.importc, header: "<X11/Xlib.h>".} = object
type Screen* {.importc, header: "<X11/Xlib.h>".} = object
type Window* {.importc, header: "<X11/Xlib.h>".} = object
type Status* {.importc, header: "<X11/Xlib.h>".} = object
type XTextProperty* {.importc, header: "<X11/Xutil.h>".} = object

proc printf(formatstr: cstring): cint {.header: "<stdio.h>", importc: "printf", varargs.}
proc XDisplayName(arg: cstring): cstring {.importc: "XDisplayName", header: "<X11/Xlib.h>".}
proc XOpenDisplay(arg: cstring): ptr Display {.importc: "XOpenDisplay", header: "<X11/Xlib.h>".}
proc XCloseDisplay(arg: ptr Display) {.importc: "XCloseDisplay", header: "<X11/Xlib.h".}
proc XScreenCount(arg: ptr Display): cint {.importc: "XScreenCount", header: "<X11/Xlib.h>".}
proc XRootWindow(arg1: ptr Display, arg2: cint): Window {.importc: "XRootWindow", header: "<X11/Xlib.h>".}
proc XRootWindowOfScreen(arg1: ptr Screen): Window {.importc: "XRootWindowOfScreen", header: "<X11/Xlib.h>".}
proc XDefaultScreenOfDisplay(arg: ptr Display): ptr Screen {.importc: "XDefaultScreenOfDisplay", header: "<X11/Xlib.h>".}
proc XFetchName(arg1: ptr Display, arg2: Window, ret: ptr cstring): Status {.importc: "XFetchName", header: "<X11/Xlib.h>".}
proc XGetWMName(display: ptr Display, w: Window, text_prop_return: ptr XTextProperty): Status {.importc: "XGetWMName", header: "<X11/Xlib.h>".}
proc XTextPropertyToStringList(text: ptr XTextProperty, ret_strings: ptr ptr cstring, count: ptr int): Status {.importc: "XTextPropertyToStringList", header: "<X11/Xlib.h>"}
proc XQueryTree(display: ptr Display, w: Window, root_return: ptr Window, parent_return: ptr Window, children_return: ptr ptr Window, nchildren_return: ptr cuint): Status {.importc: "XQueryTree", header: "<X11/Xlib.h>".}
# Status XQueryTree(Display *display, Window w, Window *root_return, Window *parent_return, Window **children_return, unsignedint *nchildren_return);

type X11Rv*[T] = object
  ## A return value for X11 related operations
  success*: bool
  ## True if operation succeeded
  message*: string
  ## Message returned by operation
  data*: T
  ## Data returned by the operation

proc `$`*[T](self: X11Rv[T]): string = 
  result = ""
  result &= "message: " & $self.message & "\n"
  result &= "success: " & $self.success & "\n"
  if self.success:
    result &= "data: " & $self.data & "\n"
  else:
    result &= "data (failed): "
  return result
  

proc wrapXDisplayName*[string](): X11Rv[string] =
  ## Gets the name of the display in use for X11
  ## 
  ## Parameters
  ##  * None
  ## 
  ## Returns
  ##  * X11Rv[string]: Data is the retval of XDisplayName on success
  let res: cstring = XDisplayName(nil)

  if res == nil:
    return X11Rv[string](success: false, message: "[wrapXDisplayName]: Nil rv", data: "")
  if res[0] == '\0':
    return X11Rv[string](success: false, message: "[wrapXDisplayName]: Empty rv", data: "")
  
  return X11Rv[string](success: true, message: "[wrapXDisplayName]: Successfully got display name", data: $res)

proc wrapXOpenDisplay*(displayName: string): X11Rv[ptr Display] = 
  assert len(displayName) > 0

  var cs: cstring = cstring(displayName)
  var res: ptr Display = XOpenDisplay(cs)

  if res == nil:
    return X11Rv[ptr Display](success: false, message: "[wrapXOpenDisplay]: Nil rv", data: nil)
  return X11Rv[ptr Display](success: false, message: "[wrapXOpenDisplay]: Successfully got Display", data: res)

proc wrapXCloseDisplay*(display: ptr Display): X11Rv[int] =
  assert display != nil
  return X11Rv[int](success: true, message: "[wrapXCloseDisplay]: Closed Display", data: 0)

proc wrapXDefaultScreenOfDisplay*(display : ptr Display): X11Rv[ptr Screen] =
  assert display != nil

  var res: ptr Screen = XDefaultScreenOfDisplay(display)

  if res == nil:
    return X11Rv[ptr Screen](success: false, message: "[wrapXDefaultScreenOfDisplay]: Nil rv", data: nil)
  return X11Rv[ptr Screen](success: false, message: "[wrapXDefaultScreenOfDisplay]: Successfully got Screen", data: res)

proc wrapXRootWindowOfScreen*(screen : ptr Screen): X11Rv[Window] =
  assert screen != nil

  var res: Window = XRootWindowOfScreen(screen)
  return X11Rv[Window](success: false, message: "[wrapXRootWindowOfScreen]: Successfully got Window", data: res)

proc wrapXFetchName*(display: ptr Display, window: Window): X11Rv[string] =
  var csr: cstring
  let s : Status = XFetchName(display, window, addr(csr))

  # Status returned from X11 functions fail on 0
  # https://tronche.com/gui/x/xlib/introduction/errors.html
  if cast[cint](s) != 0:
    return X11Rv[string](success: true, message: "[wrapXFetchName]: Success", data: $csr)
  return X11Rv[string](success: false, message: "[wrapXFetchName]: Fail", data: "")

proc wrapXGetWMName(display: ptr Display, window: Window): X11Rv[string] =
  var text: XTextProperty
  var s: Status = XGetWMName(display, window, addr(text))
  if cast[cint](s) != 0:
    var rs: cstringArray
    var cnt: int
    discard XTextPropertyToStringList(addr(text), cast[ptr ptr cstring](addr(rs)), addr(cnt))
    if cnt == 1:
      return X11Rv[string](success: true, message: "[wrapXGetWMName]: Success", data: $rs[0])
    else:
      return X11Rv[string](success: false, message: "[wrapXGetWMName]: Count not 1", data: "")
  return X11Rv[string](success: false, message: "[wrapXGetWMName]: Unknown error", data: "")

#[
  Below are functions that are not wrappers
]#

proc enumWindows*(resWindows: var seq[Window], display: ptr Display, window: Window, depth: int) =
  ## FIXME: This doesn't seem to enumerate everything?
  var csr: cstring
  # var s : Status = XFetchName(display, window, addr(csr))

  # # Status returned from X11 functions fail on 0
  # # https://tronche.com/gui/x/xlib/introduction/errors.html
  # if cast[cint](s) != 0:
  # let s: X11Rv[string] = wrapXFetchName(display, window)
  let s: X11Rv[string] = wrapXGetWMName(display, window)
  if s.success:
    resWindows.add(window)

    # for i in 0..depth - 1:
    #   discard printf("\t")

    # discard printf("id=0x%x, XFetchName=\"%s\", status=%d\n", window, csr, cast[cint](s));
    # discard printf("id=0x%x, XFetchName=\"%s\", status=%d\n", window, cstring(s.data), s.success);

  var root, parent : Window
  var children: ptr Window
  var n: cuint
  # echo len(children)
  discard XQueryTree(display, window, addr(root), addr(parent), cast[ptr ptr Window](addr(children)), addr(n));
  if children != nil:
    for i in 0..n-1:
      enumWindows(resWindows, display, cast[ptr UncheckedArray[Window]](children)[i], depth + 1)

proc getWindowByName*(display: ptr Display, name: string): X11Rv[Window] =
  assert display != nil
  var ws: seq[Window] = @[]
  var sX11Rv: X11Rv[ptr Screen] = wrapXDefaultScreenOfDisplay(display)
  var wX11Rv: X11Rv[Window] = wrapXRootWindowOfScreen(sX11Rv.data)

  enumWindows(ws, display, wX11Rv.data, 0)

  for w in ws:
    let res: X11Rv[string] = wrapXFetchName(display, w)
    if res.success and res.data == name:
      return X11Rv[Window](success: true, message: "[getWindowByName]: Found by name", data: w)
  return X11Rv[Window](success: false, message: "[getWindowByName]: Unable to find by name", data: cast[Window](nil))