extends CanvasLayer

@onready var crop_count = $"Crops/Crop Count"
@onready var player = $"../Player"

func _on_player_crop_collected():
		crop_count.text=str(player.crop_quantity)
