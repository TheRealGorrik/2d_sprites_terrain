extends Node2D

@onready var tileMap = $TileMap

@export var scaler: float = 4
var scaleVector = Vector2(scaler, scaler)

var noiseMap = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	if(noiseMap):
		for vect in noiseMap.keys():
			var value = noiseMap[vect]
			var tile = getNoiseMapTile(value)
			tileMap.set_cell(0, vect, 1, tile)
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# var cellSize = tileMap.cell_quadrant_size
	if(noiseMap):
		for loc in noiseMap.keys():
			var value = noiseMap[loc]
			var tileArr = getNoiseMapTile(value)
			tileMap.set_cell(0, loc, 1, tileArr[0])			
			var cell: TileData = tileMap.get_cell_tile_data(0, loc)		
			cell.modulate = tileArr[1]
	pass

func getNoiseMapTile(noiseValue: float):
	if (0.0 <= noiseValue && noiseValue <= 0.2):
		return [Vector2(3, 3), Color.BLUE]
	elif (0.2 <= noiseValue && noiseValue <= 0.22):
		return [Vector2(5, 4), Color.KHAKI]
	elif (0.22 <= noiseValue && noiseValue <= 0.6):
		return [Vector2(11, 12), Color.DARK_GREEN]
	elif (0.6 <= noiseValue && noiseValue <= 1):
		return [Vector2(0, 13), Color.DARK_GRAY]
	else:
		return [Vector2(0, 9), Color.DEEP_PINK]
