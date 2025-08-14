extends Control

signal play_pressed
signal settings_pressed
signal quit_pressed


func _ready() -> void:
	Global.music.fade_to(Global.music.menu_music)


func _on_play_pressed() -> void:
	play_pressed.emit()

func _on_settings_pressed() -> void:
	settings_pressed.emit()

func _on_quit_pressed() -> void:
	quit_pressed.emit()
