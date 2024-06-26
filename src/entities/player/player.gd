extends CharacterBody2D

class_name Player

# signals

signal health_changed
signal crop_changed
signal hit(amount)

@export var speed: float = 250
@export var turret_scene: PackedScene

@onready var forward: Vector2 = Vector2.DOWN
@onready var hitbox: CollisionShape2D = $Hitbox
@onready var shader_material = $Sprite2D.material
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# movement

var horizontal_dir: int = 0
var vertical_dir: int = 0

var interactables: Array = []

var dead: bool = false


func _process(_delta) -> void:
	if Input.is_action_just_pressed("place_turret") and PlayerState.crop_amount > 0:
		_add_turret()
		PlayerState.decrease_crop_amount(1)
		crop_changed.emit()
	if Input.is_action_just_pressed("interact") and !interactables.is_empty() and PlayerState.crop_amount >= 2:
		interactables[0].interact(self)
		PlayerState.decrease_crop_amount(2)
		crop_changed.emit()

func add_crop() -> void:
	PlayerState.increase_crop_amount(1)
	crop_changed.emit()

func _add_turret() -> void:
	var turret_instance = turret_scene.instantiate().initialize(get_parent(), hitbox.global_position + (forward * 20))

func _on_interaction_area_interactable_entered(area: Interactable) -> void:
	interactables.insert(0,area)

func _on_interaction_area_interactable_exited(area: Interactable) -> void:
	interactables.erase(area)
	
func notify_hit(damage_amount: int) -> void:	
	hit.emit(damage_amount)
	
	
func _handle_dead() -> void:
	set_physics_process(false)
	collision_layer = 0
	hide()
	
func enable_hit_flash() -> void:
	shader_material.set_shader_parameter("active", true)
	
func disable_hit_flash() -> void:
	shader_material.set_shader_parameter("active", false)	
	
	
# State Machine Methods

func _handle_move_input() -> void:
	horizontal_dir = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	vertical_dir = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	var velocity: Vector2 = Vector2(horizontal_dir,vertical_dir).normalized() * speed

	if velocity != Vector2.ZERO:
		forward = velocity.normalized()
	
	set_velocity(velocity)
	

func _apply_movement() -> void:
	move_and_slide()	
	
func _handle_hit(damage_amount: int) -> void:
	PlayerState.decrease_health(damage_amount)
	health_changed.emit()
	
	if PlayerState.health <= 0:
		dead = true
	
	animation_player.play("hit")	
	audio_player.play()
	
