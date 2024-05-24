extends Node2D

@export var health: float = 10000

@onready var health_bar: ProgressBar = $HealthBar

# Called when the node enters the scene tree for the first time.
func _ready():
	health_bar.init_health(health)

func notify_hit(damage_amount: float) -> void:
	health -= damage_amount
	health_bar.health = health
	
	if health <= 0:
		hide()
	

