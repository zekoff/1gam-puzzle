Jewel = require '../entity/jewel'
Field = require '../entity/field'
Hud = require '../entity/hud'
TimedScorer = require '../entity/timed_scorer'
c = require '../util/const'
conv = require '../util/convert'

state = {}
hud = null
field = null
scorer = new TimedScorer

TOTAL_TIME = 15000
timeLeft = 1

state.create = ->
    hud = new Hud()
    field = new Field(6, 44)
    field.addScoreListener scorer
    
state.update = ->
    timeLeft += scorer.getTimeBonus()
    timeLeft = 1 if timeLeft > 1
    timeLeft -= game.time.physicsElapsedMS / TOTAL_TIME
    hud.updateTimer(timeLeft) if timeLeft > 0

module.exports = state