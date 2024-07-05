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

# Objectives
var objectives = [
	{
		"description": "harvest some plants",
		"resource_type": "crop",
		"amount_required": 3,
	},
	{
		"description": "plant some defenses",
		"resource_type": "turret",
		"amount_required": 3,
	},
	{
		"description": "feed the spaceship to generate fuel",
	},
	{
		"description": "start the fuel generation",
	},
	{
		"description": "protects the ship until it is ready for take-off",
	},
	{
		"description": "time to leave!",
	}]


# Objectives signals
signal objective_updated(objective)

# Game state related signals
signal attack_mode_engaged

		

func get_current_objective():
	if objectives.size() > 0:
		return objectives[0]
		

func update_objectives_if_required() -> void:
	var current_objective = get_current_objective()
	
	if not (current_objective and current_objective.has("resource_type")):
		return
	
	match current_objective["resource_type"]:
		"crop":
			if player_crop_amount >= current_objective["amount_required"]:
				objectives.pop_front()
				print("objective done")
				objective_updated.emit(get_current_objective())				
		"turret":
			if turret_count >= current_objective["amount_required"]:
				objectives.pop_front()
				objective_updated.emit(get_current_objective())
				
	


func decrease_health(amount: int) -> void:
	player_health -= amount
	if player_health <= 0:
		player_died.emit()
	player_health_changed.emit(player_health)
	
	
func increase_crop_amount(amount: int) -> void:
	player_crop_amount += amount
	player_crop_amount_changed.emit(player_crop_amount)
	update_objectives_if_required()
	

func decrease_crop_amount(amount: int) -> void:
	player_crop_amount -= amount
	player_crop_amount_changed.emit(player_crop_amount)	
	
	
func increase_turret_amount(amount: int) -> void:
	turret_count += amount
	turret_count_changed.emit(turret_count)
	update_objectives_if_required()
	
	
	
func decrease_turret_amount(amount: int) -> void:
	turret_count -= amount
	turret_count_changed.emit(turret_count)
	

func start_attack_mode() -> void:
	attack_mode_engaged.emit()

