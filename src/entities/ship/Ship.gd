extends StaticBody2D

class_name Ship

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var generation_rate: Timer = $GenerationRate

@export var crop_required: int = 3
@export var fuel_required: int = 10

var crop_amount: int = 0
var fuel_amount: int = 0

var creating_fuel: bool = false


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	interaction_area.action_name = "to add crop. %s remaining." % (crop_required - crop_amount)

	
func _on_interact() -> void:
	
	if creating_fuel:
		return
	
	if crop_amount < crop_required:
		if Global.player_crop_amount > 0:
			Global.decrease_crop_amount(1)
			crop_amount += 1
			interaction_area.action_name = "add crop. %s remaining." % (crop_required - crop_amount)
			print("Adding crop. Remaining: ", crop_required - crop_amount)
			if crop_amount >= crop_required:
				interaction_area.action_name = "start generating fuel"				
			return
		else:
			print("not enough crop")
			return
	
	if not creating_fuel:
		creating_fuel = true
		interaction_area.can_interact = false
		interaction_area.action_name = "Start fuel generation"
		generation_rate.start()
		Global.start_attack_mode()
		return
	


func _on_generation_rate_timeout():
	if fuel_amount < fuel_required:
		fuel_amount += 1
		interaction_area.action_name = "Generating fuel. %s/%s" %[fuel_amount, fuel_required]
		generation_rate.start()
		return
		
	interaction_area.can_interact = true
	interaction_area.action_name = "take off!"
