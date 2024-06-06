extends Control

func _ready():
	hide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_menu"):
		show()
		get_tree().paused = true


func _on_resume_pressed():
	hide()
	get_tree().paused = false


