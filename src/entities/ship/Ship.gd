extends StaticBody2D

class_name Ship

signal making_noise(location)

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var generation_rate: Timer = $GenerationRate

@export var crop_required: int = 3
@export var fuel_required: int = 10

var crop_amount: int = 0
var fuel_amount: int = 0

var creating_fuel: bool = false


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

	
func _on_interact() -> void:
	if crop_amount < crop_required:
		if Global.player_crop_amount > 0:
			print("Adding crop. Remaining: ", crop_required - crop_amount)
			crop_amount += 1
			return
		else:
			print("not enough crop")
			return
	
	if not creating_fuel:
		print("start fuel generation")
		creating_fuel = true
		making_noise.emit()
		generation_rate.start()
		return
	
	print("generating fuel...")
	


func _on_generation_rate_timeout():
	if fuel_amount < fuel_required:
		fuel_amount += 1
		print("Fuel generated. Total: ", fuel_amount, " Remaining: ", fuel_required - fuel_amount)
		generation_rate.start()
		return
		
	print("ready to go!")
