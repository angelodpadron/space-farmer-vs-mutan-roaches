extends Node

#Player state and signals
signal player_crop_amount_changed(new_value)
var player_crop_amount: int = 0

# Weapon state and signals
signal turret_count_changed(new_value)
var turret_count: int = 0

# Ship state and signals
var ship_can_generate_fuel: bool = false
var ship_is_generating_fuel: bool = false
var ship_is_ready_to_go: bool = false

# Seedpack state and signals
var seedpack_picked_up: bool = false


# Objectives
var objectives = [
	{
		"description": "grab the seed bag",
		"resource_type": "seedpack",
	},
	{
		"description": "cultivate 5 plants",
		"resource_type": "crop",
		"amount_required": 5,
	},
	{
		"description": "place one or more turrets to defend the ship",
		"resource_type": "turret",
		"amount_required": 1,
	},
	{
		"description": "feed the spaceship to generate fuel",
		"resource_type": "ship_crop"
	},
	{
		"description": "start the fuel generation",
		"resource_type": "ship_start_fuel_generation"
	},
	{
		"description": "protects the ship until it is ready for take-off",
		"resource_type": "ship_fuel"
	},
	{
		"description": "time to leave!",
	}]


# Objectives signals
signal objective_updated(objective)

# Game state related signals
signal attack_mode_engaged
signal player_died
signal player_win
signal ship_destroyed
		

func get_current_objective():
	if objectives.size() > 0:
		return objectives[0]
		
		
func handle_objective_event(event: String) -> void:
	match event:
		"seedpack_picked_up":
			seedpack_picked_up = true
		"ready_to_generate_fuel":
			ship_can_generate_fuel = true
		"generating_fuel":
			ship_is_generating_fuel = true
		"ready_to_go":
			ship_is_ready_to_go = true
	
	update_objectives_if_required()

func update_objectives_if_required() -> void:
	var current_objective = get_current_objective()
	
	if not (current_objective and current_objective.has("resource_type")):
		return
	
	match current_objective["resource_type"]:
		"seedpack":
			if seedpack_picked_up:
				objectives.pop_front()
				objective_updated.emit(get_current_objective())
		"crop":
			if player_crop_amount >= current_objective["amount_required"]:
				objectives.pop_front()
				print("objective done")
				objective_updated.emit(get_current_objective())				
		"turret":
			if turret_count >= current_objective["amount_required"]:
				objectives.pop_front()
				objective_updated.emit(get_current_objective())
		"ship_crop":
			if ship_can_generate_fuel:
				objectives.pop_front()
				objective_updated.emit(get_current_objective())
		"ship_start_fuel_generation":
			if ship_is_generating_fuel:
				objectives.pop_front()
				objective_updated.emit(get_current_objective())
		"ship_fuel":
			if ship_is_ready_to_go:
				objectives.pop_front()
				objective_updated.emit(get_current_objective())
				


func increase_crop_amount(amount: int) -> void:
	player_crop_amount += amount
	player_crop_amount_changed.emit(player_crop_amount)
	update_objectives_if_required()


func has_enough_crop(amount: int) -> bool:
	return player_crop_amount >= amount
	

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

