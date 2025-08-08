extends RigidBody3D

@onready var smoke_particles: GPUParticles3D = $SmokeParticles
@onready var collision_shape: CollisionShape3D = $CollisionShape3D



func _ready() -> void:
	pass


func destroy():
	freeze = true
	
	# Shrink the collision and mesh
	var tween: Tween = create_tween()
	tween.tween_property(collision_shape, "scale", Vector3.ZERO, 0.15)
	
	smoke_particles.emitting = true
	
	await smoke_particles.finished
	queue_free()


func spin():
	var force = Vector3(0.0, 20.0, 0.0)
	apply_torque(force)


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			destroy()
