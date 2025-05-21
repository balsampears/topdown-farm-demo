extends NodeState

@export var checken:Checken
@export var animated_sprite:AnimatedSprite2D
@export var navigation_agent: NavigationAgent2D
@export var min_speed:float = 5.0
@export var max_speed:float = 10.0

var speed:float

func _ready() -> void:
	navigation_agent.velocity_computed.connect(on_safe_velocity_compluted)
	
	call_deferred("movement_setting")
	
func movement_setting()->void:
	await get_tree().physics_frame
	await get_tree().physics_frame
	set_move_target()

func set_move_target()->void:
	var target_position = NavigationServer2D.map_get_random_point(navigation_agent.get_navigation_map(), navigation_agent.navigation_layers, false)
	navigation_agent.target_position = target_position
	speed = randf_range(min_speed, max_speed)

func _on_process(delta)->void:
	pass
	
func _on_physics_process(delta)->void:
	if navigation_agent.is_navigation_finished():
		set_move_target()
		return
	
	var target_position:Vector2 = navigation_agent.get_next_path_position()
	var target_direction = checken.global_position.direction_to(target_position)
	animated_sprite.flip_h = target_direction.x < 0
	
	var velocity = target_direction * speed
	if navigation_agent.avoidance_enabled:
		navigation_agent.velocity = velocity
	else:
		checken.velocity = velocity
		checken.move_and_slide()

func on_safe_velocity_compluted(safe_velocity:Vector2)->void:
	checken.velocity = safe_velocity
	checken.move_and_slide()

func _on_next_transitions()->void:
	if navigation_agent.is_navigation_finished():
		var target_position = navigation_agent.get_next_path_position()
		checken.velocity = Vector2.ZERO
		transition.emit("Idle")
	
func _on_enter()->void:
	animated_sprite.play("walk")
	
func _on_exit()->void:
	animated_sprite.stop()
