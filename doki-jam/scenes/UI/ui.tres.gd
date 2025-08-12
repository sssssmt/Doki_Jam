class_name UI
extends CanvasLayer

@onready var game_over_screen: GameOver = $GameOverScreen


func _ready() -> void:
	Global.ui = self
