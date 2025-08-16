# Target is inherited by other shapes
class_name Target
extends RigidBody3D

@onready var smoke_particles: GPUParticles3D = $SmokeParticles
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var lifetime_timer: Timer = $Lifetime
@onready var bullet_trail: BulletTrail = $BulletTrail

@export var points: int = 1
@export var despawns: bool = true
@export var destructable: bool = true
@export var can_trigger_ricochet: bool = true
@export var can_ricochet: bool = true


func _ready() -> void:
	if can_ricochet:
		add_to_group("can_ricochet")


func destroy(was_shot:= true, can_quickshot:= true):
	if was_shot:
		Global.timer.time_left += 1
	
	remove_from_group("can_ricochet")
	collision_shape.disabled = true
	freeze = true
	lifetime_timer.stop()
	
	# Shrink the collision and mesh
	var tween: Tween = create_tween()
	tween.tween_property(collision_shape, "scale", Vector3.ZERO, 0.15)
	
	smoke_particles.emitting = true
	
	# Score
	var quickshot_mult = 1.0
	if was_shot:
		Global.audio_sfx.destroy.play()
		
		var ping = preload("res://scenes/score_ping.tscn").instantiate()
		add_child(ping)
		if Global.multiplier > 1.0:
			ping.modulate = Color.CORAL
			ping.outline_modulate = Color.FIREBRICK
		
		# Quickshot
		if can_quickshot:
			if not is_zero_approx(Global.quickshot_window):
				ping.quickshot.show()
				quickshot_mult = 2.0
			
			Global.start_quickshot_timer()
		
		var points_scored = int(points * Global.multiplier * quickshot_mult)
		Global.score += points_scored
		ping.text = str(points_scored)
		Global.combo += 1
	
	await smoke_particles.finished
	queue_free()


func ricochet(bounces_left: int = -1):
	remove_from_group("can_ricochet")
	bullet_trail.global_position = global_position
	
	await get_tree().create_timer(0.1).timeout
	var ricochet_target: Target = get_tree().get_first_node_in_group("can_ricochet")
	if ricochet_target:
		Global.audio_sfx.ricochet.play(0.11)
		
		# Make bullet trail
		bullet_trail.draw_trail(ricochet_target.global_position)
		
		
		ricochet_target.destroy(true, false)
		ricochet_target.ricochet()
	else:
		# Hides the trail of the last Target
		bullet_trail.hide()


func spin():
	var force = Vector3(0.0, 20.0, 0.0)
	apply_torque(force)


# Overridden by inheritance
func on_hit():
	Global.register_hit()


## Signals

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("fire"):
			on_hit()
			if destructable:
				destroy()
		elif event.is_action_pressed("fire_ricochet"):
			on_hit()
			if destructable:
				destroy()
			if can_trigger_ricochet:
				if Global.ricochet_token:
					Global.ricochet_token -= 1
					ricochet()



func _on_lifetime_timeout() -> void:
	if despawns == true:
		destroy(false, false)
