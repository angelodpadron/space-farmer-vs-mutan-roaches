extends Node

#Player state related signals
signal player_health_changed(new_value)
signal player_crop_amount_changed(new_value)
signal turret_count_changed(new_value)
signal player_died

# Player state
var player_health: int = 1
var player_crop_amount: int = 0
var turret_count: int = 0


# Game state related signals
signal attack_mode_engaged


func decrease_health(amount: int) -> void:
	player_health -= amount
	if player_health <= 0:
		player_died.emit()
	player_health_changed.emit(player_health)
	
	
func increase_crop_amount(amount: int) -> void:
	player_crop_amount += amount
	player_crop_amount_changed.emit(player_crop_amount)
	

func decrease_crop_amount(amount: int) -> void:
	player_crop_amount -= amount
	player_crop_amount_changed.emit(player_crop_amount)	
	
	
func increase_turret_amount(amount: int) -> void:
	turret_count += amount
	turret_count_changed.emit(turret_count)
	
	
func decrease_turret_amount(amount: int) -> void:
	turret_count -= amount
	turret_count_changed.emit(turret_count)
	

func start_attack_mode() -> void:
	attack_mode_engaged.emit()

