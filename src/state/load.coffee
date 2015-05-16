c = require('../util/const')

state = {}

state.preload = ->
    state.load.baseURL = './assets/'

state.create = ->
    for color in c.COLORS
        state.load.image "#{color}_square", "element_#{color}_square.png"
    state.load.start()
    state.add.text(0, 0, "Loading assets...")
    
state.update = ->
    state.game.state.start 'title' if state.load.hasLoaded

module.exports = state