extends Node

@export var initial_node_state: NodeState

var node_states: Dictionary = {}
var cur_node_state: NodeState
var cur_node_state_name: String
var parent_node_name: String

func _ready() -> void:
	parent_node_name = get_parent().name
	
	for child in get_children():
		if child is NodeState:
			node_states[child.name.to_lower()] = child
			child.transition.connect(transition_to)
			
	if initial_node_state:
		initial_node_state._on_enter()
		cur_node_state = initial_node_state
		cur_node_state_name = initial_node_state.name.to_lower()

		
func _process(delta: float) -> void:
	if cur_node_state:
		cur_node_state._on_process(delta)
		
func _physics_process(delta: float) -> void:
	if cur_node_state:
		cur_node_state._on_physics_process(delta)
		cur_node_state._on_next_transitions()
		#print(parent_node_name, ' 当前状态：', cur_node_state_name)
		
func transition_to(next_node_name: String)->void:
	next_node_name = next_node_name.to_lower()
	if next_node_name == cur_node_state_name:
		return
		
	var next_node = node_states[next_node_name]
	if !next_node:
		return
		
	if cur_node_state:
		cur_node_state._on_exit()
		
	next_node._on_enter()
	#print('进入',next_node_name,'状态')
	cur_node_state_name = next_node_name
	cur_node_state = next_node
		
