extends BaseGameDialogueBalloon

@onready var emote_panel: EmotePanel = $Balloon/Panel/Dialogue/HBoxContainer/EmotePanel

func start(dialogue_resource: DialogueResource, title: String, extra_game_states: Array = []) -> void:
	super.start(dialogue_resource, title, extra_game_states)
	emote_panel.play_emote("emote_12_talk")
	
func next(next_id: String) -> void:	
	super.next(next_id)
	emote_panel.play_emote("emote_12_talk")
