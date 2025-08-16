extends CanvasLayer


@onready var next: Button = %Next
@onready var slides: Control = %Slides

var slides_left: int


func _ready() -> void:
	if Global.music:
		await  get_tree().create_timer(0.1).timeout
		Global.music.fade_to(Global.music.doki_theme, 3.0)


func _on_next_pressed() -> void:
	%RestartTutorial.show()
	
	slides_left = 0
	var hidden:= false
	
	var ordered_slides = slides.get_children()
	ordered_slides.reverse()
	for slide: Control in ordered_slides:
		if slide.visible:
			if not hidden:
				slide.hide()
				hidden = true
			
			else:
				slides_left += 1
	
	# Last slide logic
	if slides_left <= 1:
		$DokiView.hide()
		%FinishTutorial.show()
		next.disabled = true


func _on_finish_tutorial_pressed() -> void:
	get_tree().paused = false
	Global.show_tutorial = false
	if Global.music:
		Global.music.fade_to(Global.music.game_music)
	queue_free()


func _on_restart_pressed() -> void:
	for slide: Control in slides.get_children():
		slide.show()
	 
	next.disabled = false
