extends Control
class_name GameOverScreen

@onready var title: Label = $%Title

var main_menu = "res://src/screens/menus/MainMenu.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	Global.player_died.connect(_on_player_died)
	Global.player_win.connect(_on_player_win)


func _on_back_to_menu_pressed():
	get_tree().change_scene_to_file(main_menu)


func show_with_title(title: String) -> void:
	self.title.text = title
	show()
	get_tree().paused = true

func _on_player_died() -> void:
	title.text = "You died"
	show()
	get_tree().paused = true


func _on_player_win() -> void:
	title.text = "You escaped!"
	show()
	get_tree().paused = true


func _on_play_again_pressed():
	get_tree().reload_current_scene()
