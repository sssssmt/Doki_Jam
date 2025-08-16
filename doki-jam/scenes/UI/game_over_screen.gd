class_name GameOver
extends Control

signal try_another_pressed

@onready var try_another: Button = %TryAnother
@onready var highscore: Label = %Highscore
@onready var score: Label = %Score
@onready var highest_combo: Label = %"Highest Combo"
@onready var best_score: Label = %BestScore
@onready var best_combo: Label = %BestCombo
@onready var message: Label = %Message



func _ready() -> void:
	hide()
	
	var tween = create_tween().set_loops()
	tween.tween_property(highscore, "visible_ratio", 0.0, 0.5).set_delay(1.0)
	tween.tween_property(highscore, "visible_ratio", 1.0, 0.5)


func display_game_over(time_out:= false):
	if time_out:
		message.text = "Time's Up Dragoon"
	else:
		message.text = "You Missed That One..."
	
	update_best()
	
	try_another.disabled = true
	show()
	await get_tree().create_timer(1.0).timeout
	try_another.disabled = false


func update_best():
	score.text = str(Global.score)
	highest_combo.text = str(Global.highest_combo)
	best_score.text = str(Global.best_high_score)
	best_combo.text = str(Global.best_combo)
	
	if score.text == best_score.text or highest_combo.text == best_combo.text:
		highscore.show()
	else:
		highscore.hide()


func _on_try_another_pressed() -> void:
	try_another_pressed.emit()


func _on_quit_pressed() -> void:
	Global.ui.quit()
