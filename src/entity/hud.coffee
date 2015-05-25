class Hud extends Phaser.Group
    TIMER_WIDTH = 120
    TIMER_HEIGHT = 10
    constructor: ->
        super(game)
        @timerBackground = game.add.sprite(26, 6, 'timer_bar')
        @timerBackground.width = TIMER_WIDTH
        @timerBackground.height = TIMER_HEIGHT
        @timer = game.add.sprite(26, 6, 'timer_bar')
        @timer.tint = 0x00FF00
        @timer.height = TIMER_HEIGHT
        @timer.width = TIMER_WIDTH / 2
    updateTimer: (percentage) ->
        @timer.width = TIMER_WIDTH * percentage
        
module.exports = Hud