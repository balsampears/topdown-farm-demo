extends Control

@onready var day_label: Label = $DayPanel/MarginContainer/DayLabel
@onready var time_label: Label = $TimePanel/MarginContainer/TimeLabel

func _ready() -> void:
	DayAndNightManager.time_tick.connect(on_time_tick)

func on_time_tick(day:int,hour:int,minutes:int)->void:
	day_label.text = "Day " + str(day)
	time_label.text = "%02d:%02d" % [hour, minutes]


func _on_normal_speed_button_pressed() -> void:
	DayAndNightManager.game_speed = 5


func _on_fast_speed_button_pressed() -> void:
	DayAndNightManager.game_speed = 20


func _on_cheatah_speed_button_pressed() -> void:
	DayAndNightManager.game_speed = 200
