extends Node3D


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		Global.bullets -= 1
