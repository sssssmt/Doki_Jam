extends Control

signal resume_pressed
signal settings_pressed
signal quit_pressed


func _on_resume_pressed() -> void:
	resume_pressed.emit()


func _on_settings_pressed() -> void:
	settings_pressed.emit()


func _on_quit_pressed() -> void:
	%Confirmation.show()
	%Options.hide()


func _on_confirm_quit_game_pressed() -> void:
	quit_pressed.emit()

func _on_cancel_pressed() -> void:
	%Options.show()
	%Confirmation.hide()

func _on_confirm_main_menu_pressed() -> void:
	%Options.show()
	%Confirmation.hide()
	Global.ui.back_to_main_menu()
