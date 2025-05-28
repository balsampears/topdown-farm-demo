extends Node

signal enabled_tools

func give_some_crops_seed()->void:
	enabled_tools.emit()
