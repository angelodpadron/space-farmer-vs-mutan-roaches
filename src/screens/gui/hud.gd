extends Control

@onready var health_bar_amount = $%HealthAmount
@onready var health_bar: HealthBar = $%HealthBar
@onready var crop_count = $%CropCount
@onready var turret_count = $%TurretCount

func _ready():
	Global.player_health_changed.connect(_update_player_health_hud)
	Global.player_crop_amount_changed.connect(_update_crop_count)
	Global.turret_count_changed.connect(_update_turret_count)
	
	
func _update_player_health_hud(amount: int) -> void:
	health_bar._set_health(amount)
	health_bar_amount.text = "%.1f" % amount
	
	
func _update_crop_count(amount: int):
	crop_count.text = "CROP    " + str(amount)
	

func _update_turret_count(amount: int):
	turret_count.text = "TURRETS    " + str(amount)
