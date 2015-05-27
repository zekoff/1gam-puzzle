class GameOver extends Phaser.Group
    constructor: ->
        super(game)
        @x = 11
        @y = 80
        background = game.make.image(0, 0, 'timer_bar')
        @add background
        background.width = 150
        background.height = 150
        button = game.make.button(25, 100, 'timer_bar', ->
            game.state.start 'title'
        )
        button.tint = 0x80FF80
        button.height = 30
        button.width = 100
        @add button
        
module.exports = GameOver