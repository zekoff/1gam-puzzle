Jewel = require '../entity/jewel'
Field = require '../entity/field'
c = require '../util/const'
conv = require '../util/convert'

state = {}
field = null

state.create = ->
    field = new Field
    
state.update = ->

module.exports = state