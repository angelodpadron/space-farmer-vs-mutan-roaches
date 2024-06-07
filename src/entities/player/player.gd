extends CharacterBody2D

class_name Player

# signals
signal health_changed(health)
signal crop_changed

@export var speed: float = 250
@export var health: float = 100.0
@export var turret_scene: PackedScene

@onready var crop_quantity: int = 0
@onready var forward: Vector2 = Vector2.DOWN
@onready var hitbox: CollisionShape2D = $Hitbox

@onready var shader_material = $Sprite2D.material

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(_delta) -> void:
	var horizontal_dir: int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	var vertical_dir: int = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	var velocity: Vector2 = Vector2(horizontal_dir,vertical_dir).normalized() * speed

	if velocity != Vector2.ZERO:
		forward = velocity.normalized()
	
	set_velocity(velocity)
	move_and_slide()

func _process(_delta) -> void:
	if Input.is_action_just_pressed("place_turret") and crop_quantity > 0:
		_add_turret()
		crop_quantity -= 1
		emit_signal("crop_changed")	
	
func add_crop() -> void:
	crop_quantity += 1
	emit_signal("crop_changed")

func _add_turret() -> void:
	var turret_instance = turret_scene.instantiate().initialize(get_parent(), hitbox.global_position + (forward * 20))

func _on_interaction_area_interactable_entered(area: Node) -> void:
	pass

func _on_interaction_area_interactable_exited(area: Node) -> void:
	pass
	
func notify_hit(damage_amount: float) -> void:
	
	animation_player.play("hit")
	
	health -= damage_amount
	audio_player.play()
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
	
func enable_hit_flash() -> void:
	shader_material.set_shader_parameter("active", true)
	
func disable_hit_flash() -> void:
	shader_material.set_shader_parameter("active", false)
	
