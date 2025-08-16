extends Node3D

@onready var targets: Node3D = $"../Targets"
@onready var ray_cast: RayCast3D = $RayCast3D

@export var target_gravity_scale: float = 1.0

@export var standard_force:= 10.0
@export var horizontal_deviation:= 0.5
@export var vertical_deviation:= 0.2

@export var rapid_fire_delay:= 0.05
@export var rapid_fire_min:= 1
@export var rapid_fire_max:= 8


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("launch_target"):
		launch_target()


func launch_target(times_repeat:int = 0):
	
	var tomato = preload("res://scenes/targets/tomato.tscn")
	var diamond = preload("res://scenes/targets/diamond.tscn")
	var pool:= [tomato, diamond]
	
	var new_target: Target = pool[randi() % pool.size()].instantiate()
	targets.add_child(new_target)
	new_target.gravity_scale = target_gravity_scale
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
	
	if times_repeat:
		times_repeat -= 1
		await get_tree().create_timer(rapid_fire_delay).timeout
		launch_target(times_repeat)


func _on_timer_timeout() -> void:
	var rapid_fire_amount = randi_range(rapid_fire_min, rapid_fire_max)
	launch_target(rapid_fire_amount)
