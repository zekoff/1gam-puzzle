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

TOTAL_TIME = 30000
timeLeft = 1

state.create = ->
    # set up background
    field = new Field(6, 44)
    field.addScoreListener scorer
    hud = new Hud()
    
state.update = ->
    hud.showMessage("Color Clear Bonus!", 150) if scorer.getColorBonus()
    hud.showMessage(scorer.getComboMessage()) if scorer.getComboMessage()
    timeLeft += scorer.getTimeBonusAndReset()
    timeLeft = 1 if timeLeft > 1
    timeLeft -= game.time.physicsElapsedMS / TOTAL_TIME
    hud.updateTimer(timeLeft) if timeLeft > 0
    hud.updateScore(scorer.getScore())

module.exports = state