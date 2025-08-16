extends Node3D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED


func load_world():
	get_tree().paused = false
	
	for child in get_children():
		if child is ShootingGallery:
			child.queue_free()
	
	var gallery = preload("res://scenes/shooting_gallery.tscn").instantiate()
	add_child(gallery)
	
	%GameOverScreen.hide()




func _on_ui_play_button_pressed() -> void:
	load_world()
	Global.music.fade_to(Global.music.game_music, 3.0)


func _on_game_over_screen_try_another_pressed() -> void:
	load_world()
	Global.ui.hide_menus()
