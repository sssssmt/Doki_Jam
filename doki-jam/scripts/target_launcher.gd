extends Node3D

@onready var targets: Node3D = $"../Targets"
@onready var ray_cast: RayCast3D = $RayCast3D

@export var standard_force:= 10.0
@export var horizontal_deviation:= 0.5
@export var vertical_deviation:= 0.2


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("launch_target"):
		launch_target()


func launch_target():
	var scenes_names = ["tomato", "diamond"]
	var scene_location:= "res://scenes/targets/%s.tscn" % scenes_names[randi() % scenes_names.size()]
	
	var new_target: Target = load(scene_location).instantiate()
	targets.add_child(new_target)
	new_target.global_position = global_position
	
	# Apply directional force
	var force:= standard_force * randf_range(1.0, 1.5) # Bit of variance
	var direction: Vector3 = ray_cast.target_position
	direction = direction.rotated(Vector3.UP, randf_range(-1.0, 1.0) * horizontal_deviation)
	direction = direction.rotated(Vector3.RIGHT, randf_range(-1.0, 1.0) * vertical_deviation)
	direction = direction.normalized()
	new_target.apply_impulse(force * direction)
	
	# Apply torque
	var torque_force = 2.0
	var torque_direction = Vector3(randf(), randf(), randf())
	var torque: Vector3 = torque_direction * torque_force
	new_target.apply_torque(torque)


func _on_timer_timeout() -> void:
	launch_target()
