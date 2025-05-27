extends Node

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("save_game"):
		save_game()
	
func save_game()->void:
	var save_level_component:SaveLevelDataComponent = get_tree().get_first_node_in_group("save_level_data_component")
	if save_level_component!=null:
		save_level_component.save_data()
		
func load_game()->void:
	var save_level_component:SaveLevelDataComponent = get_tree().get_first_node_in_group("save_level_data_component")
	if save_level_component!=null:
		save_level_component.load_data()
	
