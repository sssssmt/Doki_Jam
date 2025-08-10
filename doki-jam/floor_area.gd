extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if body is Target:
		var target = body
		target.destroy(false)
