# Target is inherited by other shapes
class_name Target
extends RigidBody3D

@onready var smoke_particles: GPUParticles3D = $SmokeParticles
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var lifetime_timer: Timer = $Lifetime
@onready var bullet_trail: BulletTrail = $BulletTrail

@export var points: int = 1


func _ready() -> void:
	add_to_group("targets")


func destroy(was_shot:= true):
	remove_from_group("targets")
	collision_shape.disabled = true
	freeze = true
	lifetime_timer.stop()
	
	# Shrink the collision and mesh
	var tween: Tween = create_tween()
	tween.tween_property(collision_shape, "scale", Vector3.ZERO, 0.15)
	
	smoke_particles.emitting = true
	
	# Score
	if was_shot:
		Global.score += points
		Global.combo += 1
		var ping = preload("res://scenes/score_ping.tscn").instantiate()
		add_child(ping)
		ping.text = str(int(points * Global.multiplier))
		if Global.multiplier > 1.0:
			ping.modulate = Color.CORAL
			ping.outline_modulate = Color.FIREBRICK
	
	await smoke_particles.finished
	queue_free()


func ricochet(bounces_left: int = -1):
	remove_from_group("targets")
	bullet_trail.global_position = global_position
	
	await get_tree().create_timer(0.1).timeout
	var ricochet_target: Target = get_tree().get_first_node_in_group("targets")
	if ricochet_target:
		# Make bullet trail
		bullet_trail.draw_trail(ricochet_target.global_position)
		
		
		ricochet_target.destroy()
		ricochet_target.ricochet()
	else:
		# Hides the trail of the last Target
		bullet_trail.hide()


func spin():
	var force = Vector3(0.0, 20.0, 0.0)
	apply_torque(force)



## Signals

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if Global.bullets <= 0:
			return
		if event.is_action_pressed("fire"):
			destroy()
		elif event.is_action_pressed("fire_ricochet"):
			destroy()
			ricochet()
		
		Global.register_hit()


func _on_lifetime_timeout() -> void:
	destroy(false)
