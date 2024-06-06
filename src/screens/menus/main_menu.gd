extends Node

@export var level: PackedScene

func _on_quit_pressed():
	get_tree().quit()

func _on_new_game_pressed():
	get_tree().change_scene_to_packed(level)
