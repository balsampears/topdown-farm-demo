extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var interactable_component: InteractableComponent = $InteractableComponent

func _on_interactable_component_interacte_activated() -> void:
	#print('open door')
	animated_sprite_2d.play('open_door')
	collision_layer = 2

func _on_interactable_component_interacte_deactivated() -> void:
	#print('close door')
	animated_sprite_2d.play("close_door")
	collision_layer = 1
