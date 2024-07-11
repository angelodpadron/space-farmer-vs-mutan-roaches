extends StaticBody2D

class_name Ship

signal health_changed(amount: int)
signal aboard
signal died
signal ready_to_generate_fuel
signal generating_fuel
signal is_ready_to_go

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var generation_rate: Timer = $GenerationRate
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var health_component: HealthComponent = $HealthComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent

@export var crop_required: int = 3
@export var fuel_required: int = 10

var crop_amount: int = 0
var fuel_amount: int = 0

var creating_fuel: bool = false
var ready_to_go: bool = false


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	interaction_area.action_name = "add crop. %s remaining." % (crop_required - crop_amount)
	health_component.health_changed.connect(_emit_health_changed)
	health_component.died.connect(_handle_dead)
	

func _emit_health_changed(amount: int) -> void:
	health_changed.emit(amount)
	
	
func _handle_dead() -> void:
	print("damm, the ship is f*#$!d")
	died.emit()

	
func _on_interact() -> void:
	
	if creating_fuel:
		return

	if ready_to_go:
		aboard.emit()
		return
	
	if crop_amount < crop_required:
		if Global.has_enough_crop(1):
			Global.decrease_crop_amount(1)
			crop_amount += 1
			interaction_area.action_name = "add crop. %s remaining." % (crop_required - crop_amount)
			if crop_amount >= crop_required:
				interaction_area.action_name = "start generating fuel"	
				ready_to_generate_fuel.emit()			
			return
		else:
			print("not enough crop")
			return
	
	if not creating_fuel:
		creating_fuel = true
		interaction_area.can_interact = false
		interaction_area.action_name = "start fuel generation"
		generation_rate.start()
		generating_fuel.emit()
		Global.start_attack_mode()
		animation_player.play("rumble")
		return
		
	


func _on_generation_rate_timeout():
	if fuel_amount < fuel_required:
		fuel_amount += 1
		interaction_area.action_name = "generating fuel. %s/%s" %[fuel_amount, fuel_required]
		generation_rate.start()
		return
		
	creating_fuel = false
	ready_to_go = true
	interaction_area.can_interact = true
	interaction_area.action_name = "take off!"
	is_ready_to_go.emit()
	animation_player.stop()
