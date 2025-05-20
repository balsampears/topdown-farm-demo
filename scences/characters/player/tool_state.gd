extends NodeState

@export var player:Player
@export var animated_sprite:AnimatedSprite2D
@export var animate_prefix:String
@export var hit_component_shape:CollisionShape2D

func _ready() -> void:
	hit_component_shape.disabled = true
	hit_component_shape.position = Vector2.ZERO

func _on_process(delta)->void:
	pass
	
func _on_physics_process(delta)->void:
	pass
	
func _on_next_transitions()->void:
	if !animated_sprite.is_playing():
		transition.emit('Idle')
	
func _on_enter()->void:
	var direction = player.player_direction
	if direction == Vector2.UP:
		animated_sprite.play(animate_prefix+"_back")
		hit_component_shape.position = Vector2(0,-20)
	elif direction == Vector2.DOWN:
		animated_sprite.play(animate_prefix+"_front")
		hit_component_shape.position = Vector2(0,2)
	elif direction == Vector2.LEFT:
		animated_sprite.play(animate_prefix+"_left")
		hit_component_shape.position = Vector2(-9,0)
	elif direction == Vector2.RIGHT:
		animated_sprite.play(animate_prefix+"_right")
		hit_component_shape.position = Vector2(9,0)
	else:
		animated_sprite.play(animate_prefix+"_front")
	
	hit_component_shape.disabled = false
	
	
func _on_exit()->void:
	animated_sprite.stop()
	hit_component_shape.disabled = true
	
