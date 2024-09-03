extends CharacterBody2D

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var input_direction: Vector2 = Vector2.ZERO
var world_position: Vector2 = Vector2(0, 0)
	
func _ready():
	update_animation_parameters()

var time = 0.0
const DURATION = 0.15

func _process(delta):	
	time += delta
	var vInput = Input.get_action_strength("right") - Input.get_action_strength("left")
	var hInput = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_direction = Vector2(vInput, hInput).normalized()
	var new_position = world_position + input_direction
	if(new_position != world_position && time > DURATION):
		world_position = new_position
		time = 0
	
	update_animation_parameters();
	move_and_slide()
	pick_new_state()

func update_animation_parameters():
	if (input_direction != Vector2.ZERO):
		animation_tree.set("parameters/walk/blend_position", input_direction)
		animation_tree.set("parameters/idle/blend_position", input_direction)
		
func pick_new_state():
	if (input_direction != Vector2.ZERO):
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")
