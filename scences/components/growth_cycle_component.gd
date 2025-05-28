extends Node
class_name GrowthCycleComponent

@export_range(5,365) var days_util_harvesting: int = 7

var current_growth_state: DataTypes.GrowthStates = DataTypes.GrowthStates.Germination
var is_watering:bool = false
var start_day:int = 0

signal crop_maturity
signal crop_harvesting

func _ready() -> void:
	DayAndNightManager.time_tick_day.connect(on_time_tick_day)
	
func on_time_tick_day(day:int) -> void:
	if is_watering:
		if start_day == 0:
			start_day = day
			
		growth_state(day)
		harvesting_growth_state(day)

func growth_state(current_day:int)->void:
	if current_growth_state >= DataTypes.GrowthStates.Maturity:
		return
	
	var num_state = 5
	var next_growth_state = (current_day - start_day) % num_state + 1
	var growth_state_name = DataTypes.GrowthStates.keys()[next_growth_state]
	#print('当前生长状态：',growth_state_name,' 序号:',next_growth_state)
	
	if current_growth_state != next_growth_state:
		current_growth_state = next_growth_state
		
	if current_growth_state == DataTypes.GrowthStates.Maturity:
		crop_maturity.emit()
		
func harvesting_growth_state(current_day:int)->void:
	if current_growth_state == DataTypes.GrowthStates.Harvesting:
		return
		
	var day_passed = (current_day - start_day) % days_util_harvesting
	
	if day_passed == days_util_harvesting - 1:
		current_growth_state = DataTypes.GrowthStates.Harvesting
		crop_harvesting.emit()
		
func get_current_growth_state()->DataTypes.GrowthStates:
	return current_growth_state
