extends Area2D
class_name FeedComponent

signal food_received


func _on_area_entered(area: Area2D) -> void:
	food_received.emit()
