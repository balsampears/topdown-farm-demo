extends Resource
class_name NodeDataResource

@export var global_position:Vector2
@export var node_path:NodePath
@export var parent_node_path:NodePath

func _save_data(node:Node2D)->void:
	global_position = node.global_position
	node_path = node.get_path()
	
	if node.get_parent()!=null:
		parent_node_path = node.get_parent().get_path()
		
func _load_data(window:Window)->void:
	pass
