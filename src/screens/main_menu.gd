extends Node

const LEVEL_1 = preload("res://src/screens/level1.tscn")

func _on_quit_pressed():
	get_tree().quit()


func _on_new_game_pressed():
	get_tree().change_scene_to_packed(LEVEL_1)
