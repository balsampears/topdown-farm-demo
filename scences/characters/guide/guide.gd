extends Node2D

@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var interactable_label_component: Control = $InteractableLabelComponent

var dialogue_scene = preload("res://dialogue/game_dialogue_balloon.tscn")
var is_inrange:bool

func _ready() -> void:
	interactable_component.interacte_activated.connect(on_activated)
	interactable_component.interacte_deactivated.connect(on_deactivated)
	interactable_label_component.hide()
	
func on_activated()->void:
	interactable_label_component.show()
	is_inrange = true
	
func on_deactivated()->void:
	interactable_label_component.hide()
	is_inrange = false

func _unhandled_input(event: InputEvent) -> void:
	if is_inrange:
		if Input.is_action_pressed("show_dialogue"):
			var balloon:BaseGameDialogueBalloon = dialogue_scene.instantiate()
			get_tree().current_scene.add_child(balloon)
			balloon.start(load("res://dialogue/conversations/guide.dialogue"), "start")
