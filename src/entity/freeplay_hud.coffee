c = require '../util/const'

class Hud extends Phaser.Group
    messages = null
    scoreText = null
    SCORE_STYLE = {
        font: 'sans-serif'
        fontSize: 20
        fontVariant: 'small-caps'
        fill: 'white'
    }
    MESSAGE_LENGTH = 2500
    MESSAGE_STYLE = {
        font: 'sans-serif'
        fontSize: 16
        fontVariant: 'small-caps'
        stroke: 'black'
        strokeThickness: 2
        fill: 'white'
        align: 'center'
        wordWrap: true
        wordWrapWidth: c.WORLD_WIDTH_PX
    }
    TIMER_WIDTH = 120
    TIMER_HEIGHT = 10
    constructor: ->
        super(game)
        @timerBackground = game.add.sprite(26, 8, 'timer_bar')
        @timerBackground.width = TIMER_WIDTH
        @timerBackground.height = TIMER_HEIGHT
        @timer = game.add.sprite(26, 8, 'timer_bar')
        @timer.tint = 0x00FF00
        @timer.height = TIMER_HEIGHT
        @timer.width = TIMER_WIDTH / 2
        messages = game.add.group()
        scoreText = game.add.text(c.WORLD_WIDTH_PX / 2, 33, "Score: 0",
            SCORE_STYLE, @)
        scoreText.anchor.set(0.5)
        @timerBackground.inputEnabled = true
        @timerBackground.events.onInputUp.add ->
            game.paused = true
            mask = game.add.image(0, 0, game.cache.getBitmapData('mask'))
            text = game.add.text(86,153,"PAUSED",{fill:'white', fontSize: 16})
            text.anchor.set 0.5
            game.input.onDown.addOnce ->
                mask.destroy()
                text.destroy()
                game.paused = false
            
    updateTimer: (percentage) ->
        @timer.width = TIMER_WIDTH * percentage
        if percentage > .7
            @timer.tint = 0x00FF00
        else if percentage > .5
            @timer.tint = 0xBBFF00
        else if percentage > .3
            @timer.tint = 0xFFFF00
        else if percentage > .15
            @timer.tint = 0xFFBB00
        else
            @timer.tint = 0xFF0000
    
    showMessage: (text, y = 180, x = c.WORLD_WIDTH_PX / 2) ->
        message = game.add.text(x, y, text, MESSAGE_STYLE, @)
        message.anchor.set(0.5)
        message.angle = -15
        messages.add message
        
    updateScore: (score) ->
        scoreText.setText "Score: #{score}"
        
    update: ->
        messages.forEachAlive (message) ->
            message.alpha -= game.time.physicsElapsedMS / MESSAGE_LENGTH
            message.y -= game.time.physicsElapsedMS / MESSAGE_LENGTH * 100
            if message.alpha < 0
                message.destroy()
        
module.exports = Hud