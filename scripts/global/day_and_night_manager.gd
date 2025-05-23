extends Node

# 每天多少分钟
const MINUTES_PER_DAY:int = 24 * 60
# 每小时多少分钟
const MINUTES_PER_HOUR:int = 60
# 每分钟多少圆周
const GAME_MINUTES_DURATION:float = TAU / MINUTES_PER_DAY

# 游戏速度
var game_speed:float = 5.0

# 初始时间
var initial_day: int = 1
var initial_hour: int = 12
var initial_minutes: int = 0

# 游戏时间
var time:float = 0
# 当前时间和天数
var current_minutes:int = -1
var current_day:int = 0

signal game_time(time:float)
signal time_tick(day:int,hour:int,minutes:int)
signal time_tick_day(day:int)

func _ready() -> void:
	set_initial_time()

func _process(delta: float) -> void:
	time += delta * game_speed * GAME_MINUTES_DURATION
	game_time.emit(time)
	recalculate_time()

func set_initial_time()->void:
	var total_minutes = initial_day * MINUTES_PER_DAY + initial_hour * MINUTES_PER_HOUR + initial_minutes
	time = total_minutes * GAME_MINUTES_DURATION

func recalculate_time()->void:
	var total_minutes = int(time / GAME_MINUTES_DURATION)
	var day = int(total_minutes / MINUTES_PER_DAY)
	var current_hour_and_minutes = total_minutes % MINUTES_PER_DAY
	var hour = int(current_hour_and_minutes / MINUTES_PER_HOUR)
	var minutes = current_hour_and_minutes % MINUTES_PER_HOUR
	
	if day != current_day:
		current_day = day
		time_tick_day.emit(day)
		
	if minutes != current_minutes:
		current_minutes = minutes
		time_tick.emit(day, hour, minutes)
