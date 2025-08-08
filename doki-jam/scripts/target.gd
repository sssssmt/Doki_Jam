class_name Target
extends RigidBody3D

@onready var smoke_particles: GPUParticles3D = $SmokeParticles
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var lifetime_timer: Timer = $Lifetime



func _ready() -> void:
	add_to_group("targets")


func destroy(is_natural_death:= false):
	collision_shape.disabled = true
	freeze = true
	lifetime_timer.stop()
	
	# Shrink the collision and mesh
	var tween: Tween = create_tween()
	tween.tween_property(collision_shape, "scale", Vector3.ZERO, 0.15)
	
	smoke_particles.emitting = true
	
	await smoke_particles.finished
	queue_free()


func ricochet(bounces_left: int = -1):
	remove_from_group("targets")
	
	await get_tree().create_timer(0.1).timeout
	var ricochet_target: Target = get_tree().get_first_node_in_group("targets")
	if ricochet_target:
		ricochet_target.destroy()
		ricochet_target.ricochet()


func spin():
	var force = Vector3(0.0, 20.0, 0.0)
	apply_torque(force)



## Signals

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("fire"):
			destroy()
		elif event.is_action_pressed("fire_ricochet"):
			destroy()
			ricochet()


func _on_lifetime_timeout() -> void:
	destroy(true)
