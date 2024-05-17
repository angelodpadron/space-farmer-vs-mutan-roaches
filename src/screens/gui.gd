extends Control

@onready var crop_count = $"HBoxContainer/Counter/Counters/Background/Crop Count"
@onready var player = $"%Player"

func _on_player_crop_changed():
	print_debug(player.crop_quantity)
	crop_count.text=str(player.crop_quantity)
