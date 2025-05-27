extends PanelContainer

@onready var log_label: Label = $MarginContainer/VBoxContainer/Logs/Label
@onready var stone_label: Label = $MarginContainer/VBoxContainer/Stone/Label
@onready var label3: Label = $MarginContainer/VBoxContainer/Corn/Label
@onready var label4: Label = $MarginContainer/VBoxContainer/Tomato/Label
@onready var label5: Label = $MarginContainer/VBoxContainer/Egg/Label
@onready var label6: Label = $MarginContainer/VBoxContainer/Milk/Label

func _ready() -> void:
	InventoryManager.inventory_changed.connect(on_inventory_changed)
	
func on_inventory_changed(item_name:String, value:int)->void:
	if item_name == "log":
		log_label.text = str(value)
	if item_name == "stone":
		stone_label.text = str(value)
	if item_name == "corn":
		label3.text = str(value)
	if item_name == "tomato":
		label4.text = str(value)
	if item_name == "egg":
		label5.text = str(value)
	if item_name == "milk":
		label6.text = str(value)
