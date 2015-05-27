class GameOver extends Phaser.Group
    constructor: ->
        super(game)
        @x = 10
        @y = 40
        background = game.make.image(0, 0, 'timer_bar')
        @add background
        background.width = 100
        background.height = 110
        button = game.make.button(10, 40, 'timer_bar', ->
            game.state.start 'title'
        )
        button.tint = 0x80FF80
        button.height = 20
        button.width = 60
        button.x = 10
        button.y = 80
        @add button
        
module.exports = GameOver