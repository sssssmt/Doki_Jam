extends Target

@onready var shiny_particles: GPUParticles3D = $ShinyParticles
@onready var cooldown: Timer = $Cooldown
@onready var voice_player: AudioStreamPlayer = $VoicePlayer


var can_be_shot: bool = true

func on_hit():
	super()
	if can_be_shot:
		Global.ricochet_token += 1
		if Global.ricochet_token:
			Global.bullets += 1
		
		voice_player.play()
		
		shiny_particles.restart()
		deactivate()


func tween_y(final_value: float):
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position:y", final_value, 3.0)


func deactivate():
	can_be_shot = false
	tween_y(10.0)
	cooldown.start()


func activate():
	can_be_shot = true
	tween_y(4.8)


func _on_cooldown_timeout() -> void:
	activate()
