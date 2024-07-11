extends ProgressBar

class_name HealthBar

@onready var timer = $Timer
@onready var damage_bar = $DamageBar

@export var MAX_VALUE: int

var health: int = 0 : set = _set_health

func _ready():
	max_value = MAX_VALUE
	health = max_value


func init_max_value(amount: int) -> void:
	max_value = amount
	health = amount

func _set_health(new_health) -> void:
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health


func _on_timer_timeout():
	damage_bar.value = health
