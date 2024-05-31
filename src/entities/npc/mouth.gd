extends Node2D

signal rumble

@export var health: float = 10000

@onready var health_bar: ProgressBar = $HealthBar
@onready var rumble_timer: Timer = $RumbleTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	health_bar.init_health(health)
	rumble_timer.timeout.connect(demand_food)

func notify_hit(damage_amount: float) -> void:
	health -= damage_amount
	health_bar.health = health
	
	if health <= 0:
		hide()
	
func demand_food() -> void:
	print_debug("mouth: feed me!")
	rumble.emit()
	

