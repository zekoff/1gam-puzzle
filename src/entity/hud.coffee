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
    MESSAGE_LENGTH = 3000
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
        
    updateTimer: (percentage) ->
        @timer.width = TIMER_WIDTH * percentage
    
    showMessage: (text, y = 180, x = c.WORLD_WIDTH_PX / 2) ->
        message = game.add.text(x, y, text, MESSAGE_STYLE, @)
        message.anchor.set(0.5)
        messages.add message
        
    updateScore: (score) ->
        scoreText.setText "Score: #{score}"
        
    update: ->
        messages.forEachAlive (message) ->
            message.alpha -= game.time.physicsElapsedMS / MESSAGE_LENGTH
            message.y -= game.time.physicsElapsedMS / MESSAGE_LENGTH * 60
            if message.alpha < 0
                message.destroy()
        
module.exports = Hud