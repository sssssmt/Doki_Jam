@tool
class_name BulletTrail
extends Node3D

@onready var trail: Node3D = $Trail
@onready var mesh_instance: MeshInstance3D = $Trail/MeshInstance
@onready var target_marker: Marker3D = $TargetMarker

## Move the Target Marker and then click the button
@export_tool_button("Draw Trail") var draw_trail_button = draw_trail


func _physics_process(_delta: float) -> void:
	# Debug
	#draw_trail()
	pass


# Takes a global position as Vector3
func draw_trail(trail_destination:= target_marker.global_position):
	target_marker.global_position = trail_destination
	
	# Vector pointing to the target marker
	var vector = target_marker.global_position - global_position
	
	# Move mesh halfway to target marker, and rotate
	trail.position = (vector) * 0.5
	trail.look_at(target_marker.global_position)
	
	# Change mesh height
	var length = vector.length() + (mesh_instance.mesh.radius * 2)
	mesh_instance.mesh.height = length
	
	# Fade
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(mesh_instance, "transparency", 1.0, 0.5)
	
	# Clean up node if it doesn't get removed automatically
	await get_tree().create_timer(1.0).timeout
	queue_free()
