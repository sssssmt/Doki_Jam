extends Control

@onready var master_slider: HSlider = %MasterSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SfxSlider
@onready var voice_slider: HSlider = %VoiceSlider


func _ready() -> void:
	# Set the sliders to the bus values
	var dict = {
		"Master": master_slider,
		"Music": music_slider,
		"SFX": sfx_slider,
		"Voice": voice_slider
	}
	for key in dict.keys():
		var bus_index = AudioServer.get_bus_index(key)
		var value = AudioServer.get_bus_volume_linear(bus_index)
		dict[key].value = value


func set_bus_volume(name: String, value: float):
	var idx = AudioServer.get_bus_index(name)
	AudioServer.set_bus_volume_linear(idx, value)


func toggle_fullscreen():
	if not DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		#DisplayServer.window_set_size(Vector2i(1280,720))


func _on_master_slider_value_changed(value: float) -> void:
	set_bus_volume("Master", value)

func _on_music_slider_value_changed(value: float) -> void:
	set_bus_volume("Music", value)

func _on_sfx_slider_value_changed(value: float) -> void:
	set_bus_volume("SFX", value)

func _on_voice_slider_value_changed(value: float) -> void:
	set_bus_volume("Voice", value)

func _on_back_pressed() -> void:
	hide()


func _on_toggle_fullscreen_pressed() -> void:
	toggle_fullscreen()
