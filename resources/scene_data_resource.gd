extends NodeDataResource
class_name SceneDataResource

@export var scene_file_path:String

func _save_data(node:Node2D)->void:
	super._save_data(node)
	
	scene_file_path = node.scene_file_path
	
func _load_data(window:Window)->void:
	var scene_node:Node2D
	var parent_node:Node2D
	
	if parent_node_path!=null:
		parent_node = window.get_node_or_null(parent_node_path)

	if node_path!=null:
		var scene = load(scene_file_path)
		scene_node = scene.instantiate() as Node2D
		
	if parent_node!=null and node_path!=null:
		scene_node.global_position = global_position
		parent_node.add_child(scene_node)
