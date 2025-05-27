extends Node
class_name SaveLevelDataComponent

@onready var parent_node_name:String = get_parent().name
@export var save_file_path:String = "user://game_data/"
@export var save_file_name:String = "save_%s_data.tres"
var save_game_resource:SaveGameResource

func _ready() -> void:
	add_to_group("save_level_data_component")

func save_data()->void:
	var save_file_full_name = save_file_name % parent_node_name
	if !DirAccess.dir_exists_absolute(save_file_path):
		DirAccess.make_dir_recursive_absolute(save_file_path)
		
	save_game_resource = SaveGameResource.new()
	save_data_nodes()
	
	var result:int = ResourceSaver.save(save_game_resource, save_file_path + save_file_full_name)
	print('保存游戏结果：',result)
	
func save_data_nodes()->void:
	var nodes = get_tree().get_nodes_in_group("save_data_component")
	if nodes!=null:
		for node:SaveDataComponent in nodes:
			var resource:Resource = node._save_data()
			var final_resource = resource.duplicate()
			save_game_resource.node_resources.append(final_resource)
			
func load_data()->void:
	var save_file_full_name = save_file_name % parent_node_name
	if !FileAccess.file_exists(save_file_full_name):
		return
		
	save_game_resource = ResourceLoader.load(save_file_path + save_file_full_name)
	if save_game_resource == null:
		return
		
	var root:Window = get_tree().root
	for resource:NodeDataResource in save_game_resource.node_resources:
		resource._load_data(root)
		
		
	
