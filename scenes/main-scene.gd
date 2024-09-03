extends Node2D

@onready var terrain = $TerrianMap
@onready var player = $Player
@onready var control = get_node("SettingsControls")
@onready var worldPositionLabel = control.world_position
@onready var noiseSeedSlider = control.noiseSeedSlider
@onready var frequencySlider = control.frequencySlider
@onready var octaveSlider = control.octaveSlider
@onready var lacunaritySlider = control.lacunaritySlider
@onready var gainSlider = control.gainSlider
@onready var noise = control.noise

@onready var scaler = terrain.scaler
@onready var scaleVector = terrain.scaleVector

var noiseMap = {}
var time = 0.0
const DURATION = 0.1
var prevWorldPosition = Vector2.ZERO

#func _input(event):	
#	if(event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_WHEEL_UP):
#		scaler += 0.1
#		scaleVector = Vector2(scaler, scaler)		
#	if(event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_WHEEL_DOWN):
#		scaler -= 0.1
#		scaleVector = Vector2(scaler, scaler)		
#	pass

func _process(_delta):		
	handleTileMap(false)
	pass

func _ready():	
	handleTileMap(true)
	pass # Replace with function body.

func handleTileMap(init: bool):
		
	var cellSize = terrain.tileMap.get("cell_quadrant_size")	
	var windowSize = get_viewport_rect().size
	var tiledWindow = windowSize / cellSize
	var wid = round(tiledWindow.x)
	var hei = round(tiledWindow.y)
	var center = windowSize / 2
	if(init):
		position = center
		terrain.tileMap.position = -(windowSize) / 2
		player.position = center - (Vector2(cellSize, cellSize) * 2)
		prevWorldPosition = player.world_position
		worldPositionLabel.text = var_to_str(player.world_position)

	if(init || prevWorldPosition != player.world_position):
		for x in range(wid):
			for y in range(hei):
				var key = Vector2(x, y)
				var sum = player.world_position + key
				noiseMap[key] = noise.get_noise_2dv(sum)

		normalizeNoiseMap(noiseMap)
		
		terrain.noiseMap = noiseMap
			
		if(!init):
			prevWorldPosition = player.world_position
			worldPositionLabel.text = var_to_str(player.world_position)
	pass

func normalizeNoiseMap(dict):
	var min_value = dict.values().min()
	var max_value = dict.values().max()

	# Normalize the values between 0 and 1
	for key in dict.keys():
		dict[key] = (dict[key] - min_value) / (max_value - min_value)
	pass
