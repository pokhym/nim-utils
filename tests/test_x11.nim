import ../x11/x11

proc testEnumerateWindows() =
  var dX11Rv: X11Rv[ptr Display] = wrapXOpenDisplay(wrapXDisplayName[string]().data)
  var sX11Rv: X11Rv[ptr Screen] = wrapXDefaultScreenOfDisplay(dX11Rv.data)
  var wX11Rv: X11Rv[Window] = wrapXRootWindowOfScreen(sX11Rv.data)

  enumWindows(dX11Rv.data, wX11Rv.data, 0)

  discard wrapXCloseDisplay(dX11Rv.data)

when isMainModule:
  testEnumerateWindows()