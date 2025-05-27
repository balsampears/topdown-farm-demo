extends Node2D

@export var corn_harvesting_scence:PackedScene
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var watering_particales: GPUParticles2D = $WateringParticales
@onready var flowering_praticles: GPUParticles2D = $FloweringPraticles
@onready var growth_cycle_component: GrowthCycleComponent = $GrowthCycleComponent
@onready var hurt_component: HurtComponent = $HurtComponent


func _ready() -> void:
	watering_particales.emitting = false
	flowering_praticles.emitting = false
	
func _process(delta: float) -> void:
	var growth_state = growth_cycle_component.get_current_growth_state()
	sprite_2d.frame = growth_state
	
	if growth_state == DataTypes.GrowthStates.Maturity:
		flowering_praticles.emitting = true

func _on_hurt_component_hurt(hit_damage: int) -> void:
	growth_cycle_component.is_watering = true
	watering_particales.emitting = true
	await get_tree().create_timer(3).timeout
	watering_particales.emitting = false

func _on_growth_cycle_component_crop_maturity() -> void:
	pass # Replace with function body.

func _on_growth_cycle_component_crop_harvesting() -> void:
	flowering_praticles.emitting = false
	var corn_harvesting = corn_harvesting_scence.instantiate() as Node2D
	corn_harvesting.global_position = global_position
	get_parent().add_child(corn_harvesting)
	queue_free()
	
