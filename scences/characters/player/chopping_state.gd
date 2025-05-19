extends NodeState

@export var player:Player
@export var animated_sprite:AnimatedSprite2D

func _on_process(delta)->void:
	pass
	
func _on_physics_process(delta)->void:
	pass
	
func _on_next_transitions()->void:
	if !animated_sprite.is_playing():
		transition.emit('Idle')
	
func _on_enter()->void:
	var direction = player.player_direction
	if direction:
		var animate_suffix = get_animate_suffix_by_direction(direction)
		animated_sprite.play("chopping"+animate_suffix)
	else:
		animated_sprite.play("chopping_front")
	
func _on_exit()->void:
	animated_sprite.stop()
