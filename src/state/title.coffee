c = require '../util/const'
W = c.WORLD_WIDTH_PX
H = c.WORLD_HEIGHT_PX
colors = c.COLORS

state = {}

textStyle =
    font: 'sans-serif'
    fontSize: 20
    fontVariant: 'small-caps'
    fill: 'white'
    
titleStyle =
    font: 'sans-serif'
    fontSize: 30
    fontVariant: 'small-caps'
    stroke: 'black'
    strokeThickness: 3
    fill: 'white'
    
buttonStyle =
    font: 'sans-serif'
    fontSize: 16
    fontVariant: 'small-caps'
    fill: 'white'
    stroke: 'black'
    strokeThickness: 2
    
state.create = ->
    game.add.image 0, 0, 'background'
    for i in [1..3]
        for c in colors
            x = game.rnd.integerInRange(0, W)
            y = game.rnd.integerInRange(0, H)
            gem = game.add.image(x, y, "#{c}_square")
            gem.angle = game.rnd.integerInRange(-45, 45)
            angleChange = game.rnd.integerInRange(-30, 30)
            newAnchor = game.rnd.frac()
            gem.anchor.set newAnchor
            tween = game.tweens.create(gem).to({angle: gem.angle + angleChange}, 300,
                Phaser.Easing.Sinusoidal.InOut, true, game.rnd.integerInRange(0, 2000),
                -1, true)
            tween.repeatDelay(game.rnd.integerInRange(500, 1500))
            tween.start()
    text = game.add.text W / 4, H / 4, "1gam", textStyle
    text.anchor.set 0.5
    text.angle = -15
    title = game.add.text W / 2, H / 3, "puzzle", titleStyle
    title.anchor.set 0.5
    button = game.add.button W / 2, H / 5 * 3, 'timer_bar', ->
        game.state.start 'main'
    button.anchor.set 0.5
    button.tint = 0x00FF00
    button.width = W/3*2
    button.height = 30
    buttonText = game.add.text W / 2, H / 5 * 3, "Arcade Mode", buttonStyle
    buttonText.anchor.set 0.5
    button2 = game.add.button W / 2, H / 5 * 4, 'timer_bar', ->
        game.state.start 'freeplay'
    button2.anchor.set 0.5
    button2.tint = 0x00FF00
    button2.width = W/3*2
    button2.height = 30
    button2Text = game.add.text W / 2, H / 5 * 4, "Free Play", buttonStyle
    button2Text.anchor.set 0.5
    
    fsb = game.add.button 86, H, 'timer_bar', ->
        game.scale.startFullScreen()
    fsb.width = 80
    fsb.height = 18
    fsb.anchor.y = 1
    fsb.anchor.x = 0.5
    fst = game.add.text 86, H + 3, "Go Fullscreen", {font: '8pt sans-serif'}
    fst.anchor.x = 0.5
    fst.anchor.y = 1
    
module.exports = state