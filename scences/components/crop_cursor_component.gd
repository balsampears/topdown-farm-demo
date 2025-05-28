extends Node
class_name CropCursorComponent

@export var tilled_soil_tilemap_layer: TileMapLayer
@export var corn_scene:PackedScene
@export var tomato_scene:PackedScene
@export var crops:Node2D

@onready var player:Player = get_tree().get_first_node_in_group("player")

var mouse_position:Vector2
var cell_position:Vector2i
var cell_source_id:int
var local_cell_position:Vector2
var distance:float

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("remove_tilled"):
		if ToolManager.current_tool == DataTypes.Tools.TillGround:
			get_cell_under_mouse()
			remove_crops()
	elif Input.is_action_pressed("hit"):
		if ToolManager.current_tool == DataTypes.Tools.PlantCorn or ToolManager.current_tool == DataTypes.Tools.PlantTomato:
			get_cell_under_mouse()
			add_crops()
			
func get_cell_under_mouse()->void:
	mouse_position = tilled_soil_tilemap_layer.get_local_mouse_position()
	cell_position = tilled_soil_tilemap_layer.local_to_map(mouse_position)
	local_cell_position = tilled_soil_tilemap_layer.map_to_local(cell_position)
	cell_source_id = tilled_soil_tilemap_layer.get_cell_source_id(cell_position)
	distance = player.global_position.distance_to(local_cell_position)
	
	print('mouse position:',mouse_position, ' cell_position:',cell_position, ' local cell position:', local_cell_position)
	print('cell source id:',cell_source_id, ' distance:',distance)
	
func add_crops()->void:
	if distance<20.0 and cell_source_id != -1:
		#去重
		var crop:Node2D = get_crop_by_crops()
		if crop == null:
			if ToolManager.current_tool == DataTypes.Tools.PlantCorn:
				var corn = corn_scene.instantiate() as Node2D
				corn.global_position = local_cell_position
				crops.add_child(corn)
			if ToolManager.current_tool == DataTypes.Tools.PlantTomato:
				var tomato = tomato_scene.instantiate() as Node2D
				tomato.global_position = local_cell_position
				crops.add_child(tomato)
			
		
func remove_crops()->void:
	if distance<20.0:
		var crop:Node2D = get_crop_by_crops()
		if crop != null:
			crop.queue_free()
				
func get_crop_by_crops()->Node2D:
	for crop:Node2D in crops.get_children():
		if crop.global_position == local_cell_position:
			return crop
	return null
	
