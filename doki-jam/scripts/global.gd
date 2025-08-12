extends Node

## Node References
var hud: HUD
var audio_music: AudioStreamPlayer
var audio_sfx: SFX
var ui: UI
var shooting_gallery: ShootingGallery


# Score Variables
@export var score: int : set = _set_score
@export var multiplier: float = 1.0 : set = _set_multiplier
var combo: int : set = _set_combo

var bullets: int = 6 : set = _set_bullets
var previous_bullet_count: int 				# Used to check for misses


#region Variable Setter Functions
func _set_score(value: int):
	var change = value - score
	score = score + (change * multiplier)
	if hud:
		hud.score_label.text = str(score)


func _set_multiplier(value: float):
	multiplier = max(value, 1.0)
	if hud:
		if multiplier <= 1.0:
			hud.multiplier_label.text = ""
		else:
			hud.multiplier_label.text = str("x", snappedf(multiplier, 0.1))


func _set_combo(value: int):
	combo = value
	var x = combo / 5
	multiplier = float(x) + 1.0
	if hud:
		hud.combo_label.text = str(combo)


func _set_bullets(value):
	value = clampi(value, 0, 6)
	bullets = value
	
	if hud:
		# Show the Bullets left
		var bullets_left = bullets
		for child in hud.bullets.get_children():
			if child is TextureRect:
				var bullet_pic = child
				if bullets_left > 0:
					bullet_pic.show()
					bullets_left -= 1
				else:
					bullet_pic.hide()
			elif child is Label:
				child.text = str(bullets)
#endregion


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("debug_increase"):	# Debug
		combo += 1
	if Input.is_action_pressed("debug_decrease"):	# Debug
		combo -= 1
	
	# Check for misses
	if previous_bullet_count != bullets:
		if previous_bullet_count > bullets:
			register_miss()
			
			# Game Over condition
			if bullets <= 0:
				game_over()
		previous_bullet_count = bullets


func register_hit():
	bullets += 1
	
	audio_sfx.hit.play()


func register_miss():
	combo = 0
	
	audio_sfx.miss.play()


func game_over():
	ui.game_over_screen.display_game_over()
	get_tree().paused = true


func try_another():
	bullets = 6
	score = 0
	get_tree().reload_current_scene()
