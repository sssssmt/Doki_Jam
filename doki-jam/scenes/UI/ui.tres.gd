class_name UI
extends CanvasLayer

signal play_button_pressed

@onready var game_over_screen: GameOver = %GameOverScreen
@onready var pause_menu: Control = %PauseMenu
@onready var settings: Control = %Settings
@onready var main_menu: MainMenu = %MainMenu



var is_paused: bool = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_paused:
			resume()
		else: 
			pause()


func _ready() -> void:
	Global.ui = self
	
	hide_menus()
	main_menu.show()


func hide_menus():
	for child in get_children():
		child.hide()


func game_over(time_out:= false):
	game_over_screen.display_game_over(time_out)


func back_to_main_menu():
	Global.music.fade_to(Global.music.menu_music, 2.0)
	
	hide_menus()
	main_menu.show()
	main_menu.anim_player.play("close_bars")
	await main_menu.anim_player.animation_finished
	main_menu.anim_player.play("opening")
	
	if Global.shooting_gallery:
		Global.shooting_gallery.queue_free()
	


func pause():
	pause_menu.show()
	is_paused = true


func resume():
	pause_menu.hide()
	settings.hide()
	is_paused = false


func toggle_settings():
	settings.visible = !settings.visible


func quit():
	Global.save_configs()
	get_tree().quit()




func _on_pause_menu_resume_pressed() -> void:
	resume()


func _on_pause_menu_settings_pressed() -> void:
	toggle_settings()


func _on_pause_menu_quit_pressed() -> void:
	quit()


func _on_main_menu_settings_pressed() -> void:
	toggle_settings()
	print("aa")


func _on_main_menu_play_pressed() -> void:
	play_button_pressed.emit()
	#hide_menus()


func _on_main_menu_quit_pressed() -> void:
	quit()
