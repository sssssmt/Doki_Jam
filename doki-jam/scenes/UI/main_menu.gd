class_name MainMenu
extends Control

signal play_pressed
signal settings_pressed
signal quit_pressed

@onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	Global.music.fade_to(Global.music.menu_music)


func _on_play_pressed() -> void:
	Global.audio_sfx.hit.play()
	anim_player.play("closing")
	play_pressed.emit()

func _on_settings_pressed() -> void:
	Global.audio_sfx.hit.play()
	settings_pressed.emit()

func _on_quit_pressed() -> void:
	quit_pressed.emit()
