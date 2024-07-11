extends Control

@onready var health_bar: HealthBar = $%HealthBar
@onready var ship_health_bar: HealthBar = $%ShipHealthBar
@onready var crop_count = $%CropCount
@onready var turret_count = $%TurretCount

@export var PLAYER_MAX_HEALTH_VALUE: int
@export var SHIP_MAX_HEALTH_VALUE: int


func _ready():
	Global.player_crop_amount_changed.connect(_update_crop_count)
	Global.turret_count_changed.connect(_update_turret_count)
	
	init_health_bars(PLAYER_MAX_HEALTH_VALUE, SHIP_MAX_HEALTH_VALUE)


func init_health_bars(player_health: int, ship_health: int) -> void:
	health_bar.init_max_value(player_health)
	ship_health_bar.init_max_value(ship_health)

	
func _update_player_health_hud(amount: int) -> void:
	health_bar._set_health(amount)
	
	
func _update_ship_health_hud(amount: int) -> void:
	ship_health_bar._set_health(amount)
	
	
func _update_crop_count(amount: int):
	crop_count.text = "CROP    " + str(amount)
	

func _update_turret_count(amount: int):
	turret_count.text = "TURRETS    " + str(amount)
