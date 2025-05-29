extends Node2D

var dialogue_scene = preload("res://dialogue/game_dialogue_balloon.tscn")
var corn_harvesting_scene = preload("res://scences/objects/plants/corn_harvesting.tscn")
var tomato_harvesting_scene = preload("res://scences/objects/plants/tomato_harvesting.tscn")
var milk_scene = preload("res://scences/objects/milk.tscn")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var interactable_label_component: Control = $InteractableLabelComponent
@onready var feed_component: FeedComponent = $FeedComponent
@onready var marker_2d: Marker2D = $Marker2D

@export var dialogue_start_command:String
@export var reward_scenes:Array[PackedScene]

var is_inrange:bool
var is_chest_open:bool

func _ready() -> void:
	interactable_label_component.hide()
	GameDialogueManager.feed_animals.connect(on_feed_animals)

func _on_interactable_component_interacte_activated() -> void:
	interactable_label_component.show()
	is_inrange = true

func _on_interactable_component_interacte_deactivated() -> void:
	if is_chest_open:
		animated_sprite_2d.play("close_chest")
	interactable_label_component.hide()
	is_inrange = false
	is_chest_open = false

func _unhandled_input(event: InputEvent) -> void:
	if is_inrange:
		if Input.is_action_just_pressed("show_dialogue"):
			animated_sprite_2d.play("open_chest")
			is_chest_open = true
			
			var balloon = dialogue_scene.instantiate() as BaseGameDialogueBalloon
			get_tree().current_scene.add_child(balloon)
			balloon.start(load("res://dialogue/conversations/chest.dialogue"), dialogue_start_command)
		
func on_feed_animals()->void:
	if is_inrange:
		trigger_feed_harvesting('corn', corn_harvesting_scene)
		
func trigger_feed_harvesting(item_name:String, scene:Resource)->void:
	if !InventoryManager.inventory.has(item_name):
		return
	
	var item_count:int = InventoryManager.inventory[item_name]
	if item_count == null or item_count == 0:
		return
		
	for i in range(item_count):
		var item = scene.instantiate() as Node2D
		item.global_position = Vector2(global_position.x, global_position.y - 30)
		get_tree().root.add_child(item)
		
		var delay = randf_range(0.5, 2.0)
		await get_tree().create_timer(delay).timeout
		
		var tween = get_tree().create_tween()
		tween.tween_property(item, "position", global_position, 1)
		tween.tween_property(item, "scale", Vector2(0.5,0.5), 1)
		tween.tween_callback(item.queue_free)
		
		InventoryManager.remove_inventory(item_name)

# 获取圆上随机一点
func get_random_position_in_circle(center:Vector2, radius: float)->Vector2:
	var arc_length:float = randf() * TAU
	# 根据弧长和半径，计算坐标(x,y)
	var x = radius * sin(arc_length) + center.x
	var y = radius * cos(arc_length) + center.y
	return Vector2(x, y)


func _on_feed_component_food_received() -> void:
	for scene in reward_scenes:
		var milk = scene.instantiate() as Node2D
		var radius = marker_2d.global_position.distance_to(global_position)
		milk.global_position = get_random_position_in_circle(global_position, radius)
		get_tree().current_scene.add_child(milk)
