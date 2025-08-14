extends Control

signal resume_pressed
signal settings_pressed
signal quit_pressed


func _on_resume_pressed() -> void:
	resume_pressed.emit()


func _on_settings_pressed() -> void:
	settings_pressed.emit()


func _on_quit_pressed() -> void:
	quit_pressed.emit()
