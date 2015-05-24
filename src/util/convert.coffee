c = require('./const')
floor = Math.floor

module.exports.worldToTile = (x, y) ->
    return [floor(x / c.TILE_SIZE), floor(y / c.TILE_SIZE)]
    
module.exports.tileToWorld = (x, y) ->
    return [x * c.TILE_SIZE + c.TILE_SIZE / 2, y * c.TILE_SIZE + c.TILE_SIZE / 2]