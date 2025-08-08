extends Node3D

@onready var targets: Node3D = $"../Targets"
@onready var ray_cast: RayCast3D = $RayCast3D

@export var standard_force:= 10.0


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("launch_target"):
		launch_target()


func launch_target():
	var new_target: Target = preload("res://scenes/target.tscn").instantiate()
	targets.add_child(new_target)
	new_target.global_position = global_position
	
	# Apply forces
	var force:= standard_force * randf_range(0.75, 1.5) # Bit of variance
	var direction: Vector3 = ray_cast.target_position
	direction = direction.rotated(Vector3.UP, randf_range(-1.0, 1.0) * 0.5)
	direction = direction.rotated(Vector3.RIGHT, randf_range(-1.0, 1.0) * 0.2)
	direction = direction.normalized()
	new_target.apply_impulse(force * direction)


func _on_timer_timeout() -> void:
	launch_target()
