extends NodeState

@export var player: Player 
@export var animated_sprite: AnimatedSprite2D
@export var speed: int = 100

func _on_process(delta)->void:
	pass
	
func _on_physics_process(delta)->void:
	var direction = GameInputEvent.movement_input()
		
	if direction:
		var animate_suffix = get_animate_suffix_by_direction(direction)
		animated_sprite.play("walk"+animate_suffix)
		
	if direction:
		player.player_direction = direction
		
	player.velocity = direction * speed
	player.move_and_slide()
	
func _on_next_transitions()->void:
	if !GameInputEvent.movement_input():
		transition.emit('Idle')
	
func _on_enter()->void:
	pass
	
func _on_exit()->void:
	animated_sprite.stop()
