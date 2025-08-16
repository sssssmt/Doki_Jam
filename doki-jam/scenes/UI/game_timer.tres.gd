class_name GameTimer
extends Label

@export var time_left: int = 100:
	set(value):
		time_left = max(value, 0)
		
		if is_inside_tree():
			text = str(time_left)


func _ready() -> void:
	time_left = time_left
	Global.timer = self


func _on_second_timeout() -> void:
	if time_left <= 0:
		Global.ui.game_over(true)
		get_tree().paused = true
	
	time_left -= 1
