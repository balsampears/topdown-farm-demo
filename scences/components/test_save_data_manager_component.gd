extends Node


func _ready() -> void:
	call_deferred("load_game")
	
func load_game()->void:
	SaveGameManager.load_game()
