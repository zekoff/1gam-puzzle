class TimedScorer
    constructor: ->
    
    field = null
    lastDestroyed = 0
    lastColor = null
    
    setField: (f) ->
        field = f
        
    preDestroy: (toDestroy) ->
        ###
        This is called after Field logic has collected all the jewels that are
        about to be destroyed, but before it has actually done so.
        ###
        lastDestroyed = toDestroy.length
        lastColor = toDestroy[0].color
    
    preRefill: ->
        ###
        This is called after the Field has destroyed all of the old jewels, but
        before it has filled their slots with new ones.
        ###
        foundColor = false
        field.forEachAlive (child) ->
            if child.color == lastColor
                foundColor = true
        console.log 'color clear bonus' if !foundColor
        
    getTimeBonus: ->
        ###
        Returns a number between 0 and 1 for how much the timer should be
        increased based on actions in the last frame.
        1 = completely refill the timer
        0 = don't refill any of the timer
        ###
        bonus = 0
        bonus = .1 if lastDestroyed > 2
        bonus = .2 if lastDestroyed > 4
        bonus = .3 if lastDestroyed > 6
        bonus = .4 if lastDestroyed > 8
        bonus = .5 if lastDestroyed > 10
        lastDestroyed = 0
        return bonus
        
module.exports = TimedScorer