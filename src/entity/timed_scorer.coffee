class TimedScorer
    constructor: ->
    
    setField: (@field) ->
        
    preDestroy: (toDestroy) ->
        ###
        This is called after Field logic has collected all the jewels that are
        about to be destroyed, but before it has actually done so.
        ###
        @lastDestroyed = toDestroy.length
        
module.exports = TimedScorer