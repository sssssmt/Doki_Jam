class_name GameOver
extends Control

@onready var buttons: VBoxContainer = $CenterContainer/VBoxContainer/Buttons

func _ready() -> void:
	hide()

func display_game_over():
	buttons.hide()
	show()
	await get_tree().create_timer(1.0).timeout
	buttons.show()

func _on_try_another_pressed() -> void:
	get_tree().paused = false
	Global.try_another()


func _on_quit_pressed() -> void:
	get_tree().quit()
