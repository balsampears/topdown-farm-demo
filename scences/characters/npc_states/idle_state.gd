extends NodeState

@export var character:NonPlayableCharacter
@export var animated_sprite:AnimatedSprite2D
@export var idle_interval_time:float = 3.0

@onready var idle_state_timer = Timer.new()
var idle_state_timeout: bool = false

func _ready() -> void:
	idle_state_timer.wait_time = idle_interval_time
	idle_state_timer.timeout.connect(on_idle_state_timeout)
	add_child(idle_state_timer)

func _on_process(delta)->void:
	pass
	
func _on_physics_process(delta)->void:
	pass
	
func _on_next_transitions()->void:
	if idle_state_timeout:
		transition.emit("Walk")
	
func _on_enter()->void:
	animated_sprite.play("idle")
	
	idle_state_timer.start()
	idle_state_timeout = false
	
func _on_exit()->void:
	animated_sprite.stop()
	idle_state_timer.stop()
	
func on_idle_state_timeout():
	idle_state_timeout = true
