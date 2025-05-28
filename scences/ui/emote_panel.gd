extends Panel
class_name EmotePanel

@onready var animated_sprite_2d: AnimatedSprite2D = $Emote/AnimatedSprite2D
@onready var emote_idle_timer: Timer = $EmoteIdleTimer

var idle_emotes = ['emote_1_idle','emote_2_smile','emote_3_ear_wave','emote_4_blink']

func _on_emote_idle_timer_timeout() -> void:
	var index = randi_range(0, idle_emotes.size()-1)
	animated_sprite_2d.play(idle_emotes[index])

func play_emote(animate_name:String)->void:
	emote_idle_timer.start()
	animated_sprite_2d.play(animate_name)
