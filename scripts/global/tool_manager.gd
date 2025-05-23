extends Node

@export var current_tool:DataTypes.Tools = DataTypes.Tools.None

signal tool_selected(tool:DataTypes.Tools)

func select_tool(tool:DataTypes.Tools)->void:
	current_tool = tool
	tool_selected.emit(tool)
