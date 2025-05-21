extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

var stone_scence = preload("res://scences/objects/rocks/stone.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	
func on_hurt(hit_damage:int)->void:
	damage_component.apply_damage(hit_damage)
	var shader = material as ShaderMaterial
	shader.set_shader_parameter("shake_intensity", 0.3)
	await get_tree().create_timer(0.5).timeout
	shader.set_shader_parameter("shake_intensity", 0)
	
func _on_damage_component_max_damage_reached() -> void:
	call_deferred("add_stone_scence")
	queue_free()

func add_stone_scence():
	var stone:Node2D = stone_scence.instantiate()
	stone.global_position = global_position
	get_parent().add_child(stone)
	
