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

TOTAL_TIME = 10000
timeLeft = null

state.create = ->
    hud = new Hud()
    field = new Field(6, 44)
    field.addScoreListener scorer
    timeLeft = TOTAL_TIME
    
state.update = ->
    if scorer.lastDestroyed > 2
        timeLeft = TOTAL_TIME
        scorer.lastDestroyed = 0
    percentage = (timeLeft-=game.time.physicsElapsedMS) / TOTAL_TIME
    hud.updateTimer(percentage) if percentage > 0

module.exports = state