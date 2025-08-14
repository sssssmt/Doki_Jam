class_name Music
extends AudioStreamPlayer

const game_music = "res://assets/Music/のんびり牧場の朝.mp3"
const menu_music = "res://assets/Music/牧場のケルトソング.mp3"
const doki_theme = "res://assets/Music/dokibird_opening.ogg"


func _init() -> void:
	Global.music = self


func fade_to(song: String, time: float = 1.0):
	# Fade Out
	var tween_out = create_tween()
	var previous_volume_linear = volume_linear
	tween_out.set_ease(Tween.EASE_IN)
	tween_out.tween_property(self, "volume_linear", 0.0, time/2)
	await tween_out.finished
	
	stream = load(song)
	play()
	
	# Fade In
	var tween_in = create_tween()
	tween_in.tween_property(self, "volume_linear", previous_volume_linear, time/2)
