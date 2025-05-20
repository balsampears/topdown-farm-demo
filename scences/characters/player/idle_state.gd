extends NodeState

@export var player: Player 
@export var animated_sprite: AnimatedSprite2D

func _on_process(delta)->void:
	pass
	
func _on_physics_process(delta)->void:
	var direction = player.player_direction
		
	if direction:
		var animate_suffix = get_animate_suffix_by_direction(direction)
		animated_sprite.play("idle"+animate_suffix)
	else:
		animated_sprite.play('idle_front')
	
func _on_next_transitions()->void:
	if GameInputEvent.movement_input():
		transition.emit('Walk')
		
	if GameInputEvent.is_hit():	
		if player.current_tool == DataTypes.Tools.AxeWood:
			transition.emit("Chopping")
		elif player.current_tool == DataTypes.Tools.TillGround:
			transition.emit('Tilling')
		elif player.current_tool == DataTypes.Tools.PlantCorn:
			transition.emit('Watering')
	
func _on_enter()->void:
	pass
	
func _on_exit()->void:
	animated_sprite.stop()
