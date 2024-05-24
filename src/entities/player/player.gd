extends CharacterBody2D

class_name Player

# signals
signal health_changed(health)
signal crop_changed

@export var speed: float = 250
@export var health: float = 100.0

@onready var crop_quantity: int = 0
@onready var forward: Vector2 = Vector2.DOWN
@onready var hitbox: CollisionShape2D = $Hitbox
@onready var interactables: Array = []

# spawnables
const CROP_SCENE: PackedScene = preload("res://src/resources/crop/crop.tscn")
const TURRENT_SCENE: PackedScene = preload("res://src/resources/turret/turret.tscn")


func _physics_process(_delta) -> void:
	var horizontal_dir: int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	var vertical_dir: int = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	var velocity: Vector2 = Vector2(horizontal_dir,vertical_dir).normalized() * speed

	if velocity != Vector2.ZERO:
		forward = velocity.normalized()
	
	set_velocity(velocity)
	move_and_slide()

func _process(delta) -> void:
	if Input.is_action_just_pressed("place_crop"):
		var crop_instance = CROP_SCENE.instantiate().initialize(get_parent(), hitbox.global_position + (forward * 20))
		print_debug(str("crop instantiated in: ", global_position + forward))
		
	if Input.is_action_just_pressed("place_turret") and crop_quantity > 0:
		_add_turret()
		crop_quantity -= 1
		emit_signal("crop_changed")
		
	if Input.is_action_just_pressed("collect_crop") and interactables:
		_add_crop()


func _add_crop() -> void:
	var cur_interaction = interactables[0]
	if cur_interaction.collectable:
		cur_interaction.collect(self)
		crop_quantity += 1
		emit_signal("crop_changed")

func _add_turret() -> void:
	var turret_instance = TURRENT_SCENE.instantiate().initialize(get_parent(), hitbox.global_position + (forward * 20))

func _on_interaction_area_interactable_entered(area: Crop) -> void:
	interactables.insert(0, area)

func _on_interaction_area_interactable_exited(area: Crop) -> void:
	interactables.erase(area)
	
func notify_hit(damage_amount: float) -> void:
	print_debug("player: ouch!", damage_amount)
	health -= damage_amount
	
	if health <= 0:
		print_debug("player: i'm dead")
		emit_signal("health_changed", 0)
		handle_dead()
		return
	
	emit_signal("health_changed", health)
	
func handle_dead() -> void:
	collision_layer = 0
	set_physics_process(false)
	hide()
