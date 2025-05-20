extends Node2D
class_name DamageComponent

@export var max_damage:int = 1
@export var cur_damage:int = 0

signal max_damage_reached

func apply_damage(damage:int)->void:
	cur_damage = clamp(cur_damage+damage,0,max_damage)
	if cur_damage == max_damage:
		max_damage_reached.emit()
