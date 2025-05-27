extends Node
class_name FieldCursorComponent

@export var grass_tilemap_layer: TileMapLayer
@export var tilled_soil_tilemap_layer: TileMapLayer
@export var terrian_set:int = 0
@export var terrian:int = 1

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
			remove_tile()
	elif Input.is_action_pressed("hit"):
		if ToolManager.current_tool == DataTypes.Tools.TillGround:
			get_cell_under_mouse()
			set_tile()
			
func get_cell_under_mouse()->void:
	mouse_position = grass_tilemap_layer.get_local_mouse_position()
	cell_position = grass_tilemap_layer.local_to_map(mouse_position)
	local_cell_position = grass_tilemap_layer.map_to_local(cell_position)
	cell_source_id = grass_tilemap_layer.get_cell_source_id(cell_position)
	distance = player.global_position.distance_to(local_cell_position)
	
	#print('mouse position:',mouse_position)
	
func set_tile()->void:
	if distance<20.0 and cell_source_id!=-1:
		tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position], terrian_set, terrian, true)
		
func remove_tile()->void:
	if distance<20.0:
		tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position], 0, -1, true)
	
	
