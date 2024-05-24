extends Control

@onready var crop_count = $"HBoxContainer/Counter/Counters/Background/Crop Count"
@onready var health_bar_gauge = $"HBoxContainer/Bars/Bar/Gauge"
@onready var health_bar_amount = $"HBoxContainer/Bars/Bar/Count/Background/Value"
@onready var player = $"%Player"

func _ready():
	_initialize_player_health()
	
func _initialize_player_health():
	update_player_health_hud(player.health)
	
func update_player_health_hud(health: float) -> void:
	var formatted_health = "%.1f" % health
	health_bar_gauge.value = health
	health_bar_amount.text = formatted_health
	
func _on_player_crop_changed():
	print_debug(player.crop_quantity)
	crop_count.text=str(player.crop_quantity)
