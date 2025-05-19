extends Node

class_name NodeState
signal transition

func _on_process(delta)->void:
	pass
	
func _on_physics_process(delta)->void:
	pass
	
func _on_next_transitions()->void:
	pass
	
func _on_enter()->void:
	pass
	
func _on_exit()->void:
	pass

func get_animate_suffix_by_direction(direction)->String:
	var animate_suffix = ""
	if !direction:
		return animate_suffix
	elif direction == Vector2.UP:
		animate_suffix = "_back"
	elif direction == Vector2.DOWN:
		animate_suffix = "_front"
	elif direction == Vector2.LEFT:
		animate_suffix = "_left"
	elif direction == Vector2.RIGHT:
		animate_suffix = "_right"
	return animate_suffix
	
