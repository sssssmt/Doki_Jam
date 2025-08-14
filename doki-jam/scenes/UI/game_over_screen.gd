class_name GameOver
extends Control

signal try_another_pressed

@onready var buttons: VBoxContainer = $CenterContainer/VBoxContainer/Buttons


func _ready() -> void:
	hide()


func display_game_over():
	buttons.hide()
	show()
	await get_tree().create_timer(1.0).timeout
	buttons.show()


func _on_try_another_pressed() -> void:
	try_another_pressed.emit()


func _on_quit_pressed() -> void:
	Global.ui.quit()
