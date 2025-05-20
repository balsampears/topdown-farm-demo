extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

var log_scence = preload("res://scences/objects/log.tscn")

func _ready() -> void:
	hurt_component.connect("hurt", on_hurt)

func on_hurt(hit_damage:int)->void:
	damage_component.apply_damage(hit_damage)
	var shader_material = material as ShaderMaterial
	shader_material.set_shader_parameter("shake_intensity", 1)
	await get_tree().create_timer(0.5).timeout
	shader_material.set_shader_parameter("shake_intensity", 0)

func _on_damage_component_max_damage_reached() -> void:
	call_deferred("drop_log")
	queue_free()
	
func drop_log()->void:
	var log = log_scence.instantiate() as Node2D
	log.position = position
	get_parent().add_child(log)
