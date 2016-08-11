var NPM_ROOT = '/usr/local/lib/node_modules/'

// require(NPM_ROOT + 'lodash')

Phoenix.set({ daemon: true, openAtLogin: true })

function runIfExists(obj, f) {
  if(!obj) {
    return
  } else {
    return f(obj)
  }
}

function dimensions(width, height, x, y) {
  return {
    width: width,
    height: height,
    x: x,
    y: y
  }
}

Key.on('left', [ 'cmd', 'shift' ], function () {
  runIfExists(Window.focused(), function(win){
    var rectangle = win.screen().visibleFrameInRectangle()
    var halfSize = Math.ceil(rectangle.width / 2)
    win.setFrame(dimensions(halfSize, rectangle.height, 0, 0))
  })
})

Key.on('right', [ 'cmd', 'shift' ], function () {
  runIfExists(Window.focused(), function(win){
    var rectangle = win.screen().visibleFrameInRectangle()
    var halfSize = Math.ceil(rectangle.width / 2)
    win.setFrame(dimensions(halfSize, rectangle.height, halfSize, 0))
  })
})

Key.on('up', [ 'cmd', 'shift' ], function () {
  runIfExists(Window.focused(), function(win){
    var rectangle = win.screen().visibleFrameInRectangle()
    var halfSize = Math.ceil(rectangle.height / 2)
    win.setFrame(dimensions(rectangle.width, halfSize, 0, 0))
  })
})

Key.on('down', [ 'cmd', 'shift' ], function () {
  runIfExists(Window.focused(), function(win){
    var rectangle = win.screen().visibleFrameInRectangle()
    var halfSize = Math.ceil(rectangle.height / 2)
    win.setFrame(dimensions(rectangle.width, halfSize, 0, halfSize))
  })
})
