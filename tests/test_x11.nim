import ../x11/x11_base

proc testEnumerateWindows() =
  var res: seq[Window] = @[]
  var dX11Rv: X11Rv[ptr Display] = wrapXOpenDisplay(wrapXDisplayName[string]().data)
  var sX11Rv: X11Rv[ptr Screen] = wrapXDefaultScreenOfDisplay(dX11Rv.data)
  var wX11Rv: X11Rv[Window] = wrapXRootWindowOfScreen(sX11Rv.data)

  enumWindows(res, dX11Rv.data, wX11Rv.data, 0)
  echo len(res)

  discard wrapXCloseDisplay(dX11Rv.data)

proc testFindWindowName() =
  var res: seq[Window] = @[]
  var dX11Rv: X11Rv[ptr Display] = wrapXOpenDisplay(wrapXDisplayName[string]().data)
  var sX11Rv: X11Rv[ptr Screen] = wrapXDefaultScreenOfDisplay(dX11Rv.data)
  var wX11Rv: X11Rv[Window] = wrapXRootWindowOfScreen(sX11Rv.data)

  var r: X11Rv[Window] = getWindowByName(dX11Rv.data, "asdf")
  # var r: X11Rv[Window] = getWindowByName(dX11Rv.data, "Zoom Workplace")
  if r.success:
    echo wrapXFetchName(dX11Rv.data, r.data)
  else:
    echo r

when isMainModule:
  # testEnumerateWindows()
  testFindWindowName()