Jewel = require '../entity/jewel'
Field = require '../entity/field'
Hud = require '../entity/hud'
TimedScorer = require '../entity/timed_scorer'
GameOver = require '../entity/game_over'
c = require '../util/const'
conv = require '../util/convert'

state = {}

hud = null
field = null
scorer = null
timeLeft = null
gameOverBool = null
TOTAL_TIME = 300

state.create = ->
    # set up background
    scorer = new TimedScorer
    field = new Field(6, 44)
    field.addScoreListener scorer
    hud = new Hud()
    timeLeft = 1
    gameOverBool = false
    
state.update = ->
    if timeLeft <= 0 && !gameOverBool
        gameOverBool = true
        new GameOver(scorer.getScore())
    hud.showMessage("Color Clear Bonus!", 150) if scorer.getColorBonus()
    hud.showMessage(scorer.getComboMessage()) if scorer.getComboMessage()
    timeLeft += scorer.getTimeBonusAndReset()
    timeLeft = 1 if timeLeft > 1
    timeLeft -= game.time.physicsElapsedMS / TOTAL_TIME
    hud.updateTimer(timeLeft) if timeLeft > 0
    hud.updateScore(scorer.getScore())
    
state.shutdown = ->
    field = null
    scorer = null

module.exports = state