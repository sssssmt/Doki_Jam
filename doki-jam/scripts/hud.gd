class_name HUD
extends CanvasLayer

# On Ready Variables
@onready var score_label: Label = %ScoreLabel
@onready var combo_label: Label = %ComboLabel
@onready var multiplier_label: Label = %MultiplierLabel
@onready var bullets: Control = $Bullets




func _init() -> void:
	Global.hud = self
