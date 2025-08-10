extends Label3D

func _ready() -> void:
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", global_position + Vector3(0.0, 0.5, 0.0), 0.5)
