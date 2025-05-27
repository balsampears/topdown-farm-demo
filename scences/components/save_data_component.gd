extends Node
class_name SaveDataComponent

@export var resource: Resource
@onready var parent_node: Node2D = get_parent()

func _ready() -> void:
	add_to_group("save_data_component")

func _save_data()->Resource:
	if parent_node == null:
		return null
	
	if resource == null:
		push_error("必须先设置资源类型", parent_node.name)
		return
		
	resource._save_data(parent_node)
	return resource
