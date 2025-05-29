extends Node

signal enabled_tools
signal feed_animals

func action_give_crops_seed()->void:
	enabled_tools.emit()

func action_feed_animals()->void:
	feed_animals.emit()
