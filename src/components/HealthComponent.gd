extends Node2D

class_name HealthComponent

signal died
signal initial_health(amount: int)
signal health_changed(amount: int)

@export var MAX_HEALTH: int = 10

var health: int


func _ready():
	health = MAX_HEALTH
	initial_health.emit(health)
	

func take_damage(amount: int):
	health -= amount
	health_changed.emit(health)
	
	if health <= 0:
		died.emit()
