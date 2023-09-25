extends Node
class_name StateMachine

@export var initial_state: State
@export var target: Node

var current_state: State
var states: Dictionary = {}

func _ready():
	if initial_state:
		current_state = initial_state
		#current_state.enter()
	
	for child in get_children():
		if child is State:
			child.init(target)
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_tansitioned)

func _process(delta):
	if current_state: current_state.update(delta)

func _physics_process(delta):
	if current_state: current_state.physics_update(delta)

func on_child_tansitioned(state, new_state_name):
	if current_state != state: return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state: return
	
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()
	
	#if target and target is Player: target.update_animation()
	print_rich("[color=yellow]Switched state to[/color]: ", current_state.name)
