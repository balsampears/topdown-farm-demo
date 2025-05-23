extends PanelContainer

@onready var log_label: Label = $MarginContainer/VBoxContainer/Logs/Label
@onready var stone_label: Label = $MarginContainer/VBoxContainer/Stone/Label

func _ready() -> void:
	InventoryManager.inventory_changed.connect(on_inventory_changed)
	
func on_inventory_changed(item_name:String, value:int)->void:
	if item_name == "log":
		log_label.text = str(value)
	if item_name == "stone":
		stone_label.text = str(value)
