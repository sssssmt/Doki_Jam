class_name SFX
extends AudioStreamPlayer

@onready var hit: AudioStreamPlayer = $Hit
@onready var destroy: AudioStreamPlayer = $Destroy
@onready var miss: AudioStreamPlayer = $Miss
@onready var ricochet: AudioStreamPlayer = $Ricochet


const fire_hitsound_sfx = [
	"res://assets/SFX/GunSFX/gunfire_and_hitsound-01.ogg",
	"res://assets/SFX/GunSFX/gunfire_and_hitsound-02.ogg",
	"res://assets/SFX/GunSFX/gunfire_and_hitsound-03.ogg",
	"res://assets/SFX/GunSFX/gunfire_and_hitsound-04.ogg"
]
const miss_sfx = ["res://assets/SFX/GunSFX/whizzby.ogg"]


func _init() -> void:
	Global.audio_sfx = self
