class TimedScorer
    constructor: ->
    
    setField: (@field) ->
        
    preDestroy: (toDestroy) ->
        ###
        This is called after Field logic has collected all the jewels that are
        about to be destroyed, but before it has actually done so.
        ###
        @lastDestroyed = toDestroy.length
        
    getTimeBonus: ->
        ###
        Returns a number between 0 and 1 for how much the timer should be
        increased based on actions in the last frame.
        1 = completely refill the timer
        0 = don't refill any of the timer
        ###
        bonus = 0
        bonus = .2 if @lastDestroyed > 2
        bonus = .4 if @lastDestroyed > 4
        bonus = .8 if @lastDestroyed > 6
        @lastDestroyed = 0
        console.log bonus
        return bonus
        
module.exports = TimedScorer