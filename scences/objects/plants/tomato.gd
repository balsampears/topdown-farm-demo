extends Node2D

@export var tomato_harvesting_scene:PackedScene

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var flowering_praticles: GPUParticles2D = $FloweringPraticles
@onready var watering_particales: GPUParticles2D = $WateringParticales
@onready var growth_cycle_component: GrowthCycleComponent = $GrowthCycleComponent
@onready var hurt_component: HurtComponent = $HurtComponent

func _ready() -> void:
	flowering_praticles.emitting = false
	watering_particales.emitting = false

func _process(delta: float) -> void:
	var growth_state = growth_cycle_component.get_current_growth_state()
	growth_state += 6 #前面六个是corn的图片
	sprite_2d.frame = growth_state
	
func _on_hurt_component_hurt(hit_damage: int) -> void:
	growth_cycle_component.is_watering = true
	watering_particales.emitting = true
	await get_tree().create_timer(3).timeout
	watering_particales.emitting = false

func _on_growth_cycle_component_crop_harvesting() -> void:
	flowering_praticles.emitting = false
	var tomato = tomato_harvesting_scene.instantiate() as Node2D
	tomato.global_position = global_position
	get_parent().add_child(tomato)
	queue_free()

func _on_growth_cycle_component_crop_maturity() -> void:
	flowering_praticles.emitting = true
