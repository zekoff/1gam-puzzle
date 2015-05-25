Jewel = require '../entity/jewel'
Field = require '../entity/field'
Hud = require '../entity/hud'
c = require '../util/const'
conv = require '../util/convert'

state = {}
hud = null
field = null

TOTAL_TIME = 5000
timeLeft = null

state.create = ->
    hud = new Hud()
    field = new Field(6, 44)
    timeLeft = TOTAL_TIME
    
state.update = ->
    percentage = (timeLeft-=game.time.physicsElapsedMS) / TOTAL_TIME
    hud.updateTimer(percentage) if percentage > 0

module.exports = state