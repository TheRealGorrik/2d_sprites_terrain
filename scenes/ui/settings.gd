extends CanvasLayer

class_name SettingsUI

var rootPath = "ViewPort/Pane/MarginContainer/VBoxContainer/GridContainer/"
@onready var world_position = get_node(rootPath + "WorldPositionValue")
@onready var noiseSeedSlider = get_node(rootPath + "NoiseSeedSlider")
@onready var frequencySlider = get_node(rootPath + "FrequencySlider")
@onready var octaveSlider = get_node(rootPath + "OctaveSlider")
@onready var lacunaritySlider = get_node(rootPath + "LacunaritySlider")
@onready var gainSlider = get_node(rootPath + "GainSlider")

@onready var world_position_text = get_node(rootPath + "WorldPositionText")
@onready var noise_seed_text = get_node(rootPath + "NoiseSeedText")
@onready var frequency_text = get_node(rootPath + "FrequencyText")
@onready var octave_text = get_node(rootPath + "OctaveText")
@onready var lacunarity_text = get_node(rootPath + "LacunarityText")
@onready var gain_text = get_node(rootPath + "GainText")

@export var noiseSeed: int = 1
@export var frequency: float = 0.035
@export var octaves: int = 6
@export var lacunarity: float = 2.0
@export var gain: float = 0.25
@export var scaler: float = 1

var noise

# Called when the node enters the scene tree for the first time.
func _ready():	
	noise = FastNoiseLite.new()		
	noiseSeedSlider.value = noiseSeed
	frequencySlider.value = frequency
	octaveSlider.value = octaves
	lacunaritySlider.value = lacunarity
	gainSlider.value = gain
	
	setTextValues()
	setNoiseValues()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	setTextValues()
	setNoiseValues()
	pass

func setNoiseValues():	
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	noise.seed = noiseSeedSlider.value
	noise.frequency = frequencySlider.value
	noise.fractal_octaves = octaveSlider.value
	noise.fractal_lacunarity = lacunaritySlider.value
	noise.fractal_gain = gainSlider.value	
	pass

func setTextValues():	
	noise_seed_text.text = var_to_str(noiseSeedSlider.value)
	frequency_text.text = var_to_str(frequencySlider.value)
	octave_text.text = var_to_str(octaveSlider.value)
	lacunarity_text.text = var_to_str(lacunaritySlider.value)
	gain_text.text = var_to_str(gainSlider.value)
	pass
