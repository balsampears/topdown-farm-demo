extends NodeDataResource
class_name TilemapLayerDataResource

@export var cells:Array[Vector2i]
@export var terrain_sets:Array[int]
@export var terrains:Array[int]

func _save_data(node:Node2D)->void:
	super._save_data(node)
	
	var tilemap = node as TileMapLayer
	cells = tilemap.get_used_cells()
	for cell in cells:
		var terrain_data = tilemap.get_cell_tile_data(cell)
		terrain_sets.append(terrain_data.terrain_set)
		terrains.append(terrain_data.terrain)
	
func _load_data(window:Window)->void:
	var scene_node = window.get_node_or_null(node_path)
	
	if scene_node!=null:
		var tilemap = scene_node as TileMapLayer
		for index in range(cells.size()):
			var cell = cells[index]
			tilemap.set_cells_terrain_connect([cell], terrain_sets[index], terrains[index], true)
