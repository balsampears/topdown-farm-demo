extends CharacterBody2D
class_name Player

@export var current_tool:DataTypes.Tools = DataTypes.Tools.None
var player_direction:Vector2
@onready var hit_component: HitComponent = $HitComponent

func _process(delta: float) -> void:
	hit_component.current_tool = current_tool
