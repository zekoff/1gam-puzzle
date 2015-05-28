c = require('../util/const')

state = {}

state.preload = ->
    #Phaser.Canvas.setImageRenderingCrisp(game.canvas)
    game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL
    game.scale.pageAlignHorizontally = true
    game.scale.pageAlignVertically = true
    game.input.maxPointers = 1
    game.load.baseURL = './assets/'

state.create = ->
    for color in c.COLORS
        game.load.image("#{color}_square", "element_#{color}_square.png")
    for n in [1..7]
        game.load.audio("ding#{n}", "sounds/Pickup_Coin#{n}.ogg")
    game.load.image("timer_bar", "timer_bar.png")
    bmp = game.add.bitmapData(c.WORLD_WIDTH_PX, c.WORLD_HEIGHT_PX, 'mask', true)
    bmp.fill(0, 0, 0, 0.7)
    game.load.start()
    game.add.text(0, 0, "Loading assets...")
    
state.update = ->
    game.state.start 'title' if game.load.hasLoaded

module.exports = state