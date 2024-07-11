extends CharacterBody2D

class_name Player

# signals (mediator pattern)
signal health_changed(amount: int)
signal initial_health(amount: int)
signal died

@export var speed: float = 250
@export var turret_scene: PackedScene

@onready var health_component: HealthComponent = $HealthComponent

const TURRET_COST: int = 5

# movement

var horizontal_dir: int = 0
var vertical_dir: int = 0

func _ready() -> void:
	health_component.initial_health.connect(_emit_initial_health)
	health_component.health_changed.connect(_emit_health_changed)
	

func _emit_initial_health(amount: int) -> void:
	initial_health.emit(amount)

func _emit_health_changed(amount: int) -> void:
	health_changed.emit(amount)

func _process(_delta) -> void:
	if Input.is_action_just_pressed("place_turret"):
		_add_turret()
			

func add_crop() -> void:
	Global.increase_crop_amount(1)

func _add_turret() -> void:
	if Global.has_enough_crop(TURRET_COST):	
			Global.decrease_crop_amount(TURRET_COST)
			Global.increase_turret_amount(1)
			turret_scene.instantiate().initialize(get_parent(), self.global_position + (Vector2.DOWN * 20))

	
	
func _handle_dead() -> void:
	died.emit()
	queue_free()
	
	
# State Machine Methods

func _handle_move_input() -> void:
	horizontal_dir = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	vertical_dir = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	set_velocity(Vector2(horizontal_dir,vertical_dir).normalized() * speed)
	

func _apply_movement() -> void:
	move_and_slide()
