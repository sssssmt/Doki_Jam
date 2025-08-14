class_name SFX
extends AudioStreamPlayer

@onready var hit: AudioStreamPlayer = $Hit
@onready var destroy: AudioStreamPlayer = $Destroy
@onready var miss: AudioStreamPlayer = $Miss
@onready var ricochet: AudioStreamPlayer = $Ricochet


func _init() -> void:
	Global.audio_sfx = self
