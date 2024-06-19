extends Control

var main_menu="res://src/screens/menus/main_menu.tscn"

func _ready():
	hide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_menu"):
		visible=!visible
		get_tree().paused = visible

func _on_resume_pressed():
	hide()
	get_tree().paused = false

func _on_main_menu_pressed():
	get_tree().paused=false
	get_tree().change_scene_to_file(main_menu)
