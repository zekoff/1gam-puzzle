c = require('./const')

module.exports.worldToTile = (x, y) ->
    return [x / c.TILE_SIZE, y / c.TILE_SIZE]
    
module.exports.tileToWorld = (x, y) ->
    return [x * c.TILE_SIZE, y * c.TILE_SIZE]