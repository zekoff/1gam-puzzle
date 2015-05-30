class TimedScorer
    constructor: ->
    
    field = null
    lastDestroyed = 0
    lastColor = null
    lastColorBonus = false
    fullClearBonus = false
    
    score: 0
    
    setField: (f) ->
        field = f
        
    preDestroy: (toDestroy) ->
        ###
        This is called after Field logic has collected all the jewels that are
        about to be destroyed, but before it has actually done so.
        ###
        lastDestroyed = toDestroy.length
        lastColor = toDestroy[0].color
        fullClearBonus = true if lastDestroyed == 40
    
    preRefill: ->
        ###
        This is called after the Field has destroyed all of the old jewels, but
        before it has filled their slots with new ones.
        ###
        foundColor = false
        field.forEachAlive (child) ->
            if child.color == lastColor
                foundColor = true
        lastColorBonus = !foundColor
        
    getNumberDestroyed: ->
        return lastDestroyed
        
    getColorBonus: ->
        return lastColorBonus && @getNumberDestroyed() > 4
        
    getFullClearBonus: ->
        return fullClearBonus
        
    getComboMessage: ->
        if @getNumberDestroyed() > 33
            return "Extraordinary!"
        else if @getNumberDestroyed() > 24
            return "Outrageous!"
        else if @getNumberDestroyed() > 17
            return "Explosive!"
        else if @getNumberDestroyed() > 10
            return "Great!"
        else if @getNumberDestroyed() > 5
            return "Nice!"
        return null

    getTimeBonusAndReset: ->
        ###
        Returns a number between 0 and 1 for how much the timer should be
        increased based on actions in the last frame.
        1 = completely refill the timer
        0 = don't refill any of the timer
        ###
        @score += Math.floor((lastDestroyed ** 1.5) * 10)
        @score += Math.floor((5 ** 1.5) * 10) if lastColorBonus
        @score += 1000 if fullClearBonus
        bonus = lastDestroyed ** 2 / 1000
        lastDestroyed = 0
        lastColorBonus = false
        fullClearBonus = false
        return bonus
    
    getScore: ->
        return @score
        
module.exports = TimedScorer