class_name InteractableComponent
extends Area2D

signal interacte_activated
signal interacte_deactivated


func _on_body_entered(body: Node2D) -> void:
	interacte_activated.emit()

func _on_body_exited(body: Node2D) -> void:
	interacte_deactivated.emit()
