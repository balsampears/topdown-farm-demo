extends Node

var inventory:Dictionary = Dictionary()

signal inventory_changed(name:String, value:int)

func add_inventory(item_name:String)->void:
	var item = inventory.get_or_add(item_name)
	if item == null:
		inventory[item_name] = 1
	else:
		inventory[item_name] += 1
	inventory_changed.emit(item_name, inventory[item_name])

func remove_inventory(item_name:String)->void:
	var item = inventory.get_or_add(item_name)
	if item == null:
		inventory[item_name] = 0
	else:
		if item > 0:
			inventory[item_name] -= 1
	inventory_changed.emit(item_name, inventory[item_name])
	
