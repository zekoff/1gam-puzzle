Jewel = require '../entity/jewel'
Field = require '../entity/field'
c = require '../util/const'
conv = require '../util/convert'

state = {}
field = null

state.create = ->
    field = new Field
    state.input.onUp.add ->
        underPointer = state.physics.arcade.getObjectsUnderPointer(
            state.input.activePointer, field)
        if underPointer.length is 1
            underPointer.forEach (jewel) ->
                console.log jewel.color
                toDestroy = []
                toDestroy.push jewel
                field.clearJewel jewel, toDestroy
                toDestroy.forEach (j) ->
                    j.kill()
        else if underPointer.length > 1
            console.log 'swap'
            #swap jewels
            underPointer.forEach (jewel) ->
                [jewel.x, jewel.y] = [jewel.prevX, jewel.prevY]
                jewel.body.reset(jewel.x, jewel.y)
    
state.update = ->

module.exports = state