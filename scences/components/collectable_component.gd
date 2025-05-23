extends Node
class_name CollectableComponent

@export var item_name:String

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print('收集了',item_name)
		get_parent().queue_free()
		
		InventoryManager.add_inventory(item_name)
