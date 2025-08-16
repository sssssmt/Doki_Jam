class_name ShootingGallery
extends Node3D



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fire") or event.is_action_pressed("fire_ricochet"):
		Global.bullets -= 1


func _ready() -> void:
	Global.shooting_gallery = self
	Global.try_another()
	
	if Global.show_tutorial:
		var tutorial = preload("res://scenes/UI/tutorial.tscn").instantiate()
		add_child(tutorial)
		get_tree().paused = true
