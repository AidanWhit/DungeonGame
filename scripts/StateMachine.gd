extends Node

@export var initial_state: State
var current_state : State
var states : Dictionary = {}

func _ready() -> void:
	
	# loop through all of the children
	for child in get_children():
		if (child is State):
			# adds the child to the dictionary of states with its name as the key
			states[child.name.to_lower()] = child;
			child.Transitioned.connect(on_child_transitioned)
	
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		#print(current_state.name.to_lower())
		current_state.Physics_Update(delta)

func on_child_transitioned(state : State, new_state_name: String):
	# prevents switching states when a current_state is not synched with the singal
	if state != current_state:
		return
	
	var new_state = states[new_state_name.to_lower()]
	# if the new state exists
	if(!new_state):
		return
	if current_state:
		current_state.Exit()
		
	new_state.Enter()
	current_state = new_state
