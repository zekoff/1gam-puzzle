class GameOver extends Phaser.Group
    constructor: (finalScore) ->
        super(game)
        @x = 11
        @y = 80
        mask = game.add.image(-@x, -@y, game.cache.getBitmapData('mask'))
        mask.inputEnabled = true
        @add mask
        background = game.make.image(0, 0, 'timer_bar')
        @add background
        background.width = 150
        background.height = 150
        button = game.make.button(25, 90, 'timer_bar', ->
            game.state.start 'title'
        )
        button.tint = 0x80FF80
        button.height = 30
        button.width = 100
        @add button
        scoreText = game.make.text(86 - @x, 60, "Final Score:\n#{finalScore}", {
            font: 'sans-serif'
            fontSize: 20
            fontVariant: 'small-caps'
            fill: 'black'
            align: 'center'
        })
        scoreText.anchor.set 0.5
        @add scoreText
        
module.exports = GameOver