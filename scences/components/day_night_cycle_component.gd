extends CanvasModulate

@export var initial_day:int = 1:
	set(id):
		initial_day = id
		DayAndNightManager.initial_day = id
		DayAndNightManager.set_initial_time()
		
@export var initial_hour:int = 12:
	set(ih):
		initial_hour = ih
		DayAndNightManager.initial_hour = ih
		DayAndNightManager.set_initial_time()

@export var initial_minutes:int = 0:
	set(im):
		initial_minutes = im
		DayAndNightManager.initial_minutes = im
		DayAndNightManager.set_initial_time()

@export var day_night_gradient_texture: GradientTexture1D

func _ready() -> void:
	DayAndNightManager.current_day = initial_day
	DayAndNightManager.current_minutes = initial_minutes
	DayAndNightManager.set_initial_time()
	
	DayAndNightManager.game_time.connect(on_game_time)
	
func on_game_time(time:float) -> void:
	var sample_value = (sin(time  - PI / 2) + 1) * 0.5
	color = day_night_gradient_texture.gradient.sample(sample_value)
