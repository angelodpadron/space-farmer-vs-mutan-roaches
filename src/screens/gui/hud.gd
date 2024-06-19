extends Control

@onready var crop_count = $"HBoxContainer/Counter/Counters/Background/Crop Count"
@onready var health_bar_amount = $"HBoxContainer/Bars/Bar/Value"
@onready var health_bar: HealthBar = $%HealthBar

func _ready():
	_initialize_player_health()
	
func _initialize_player_health():
	health_bar.init_health(PlayerState.health)
	update_player_health_hud()
	
func update_player_health_hud() -> void:
	health_bar._set_health(PlayerState.health)
	var formatted_health = "%.1f" % PlayerState.health
	health_bar_amount.text = formatted_health
	
func _on_player_crop_changed():
	crop_count.text=str(PlayerState.crop_amount)
