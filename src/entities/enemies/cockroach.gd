extends CharacterBody2D

class_name Cockroach

@export var speed: float = 100
@export var health: float = 15
@export var damage_amount: int = 1
@export var knockback_multiplier : float = 50

@onready var attack_rate: Timer = $AttackRate
@onready var healthbar: ProgressBar = $HealthBar
@onready var body_sprite: Sprite2D = $Sprite2D

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shader_material = $Sprite2D.material

var main_target: Node = null
var current_target: Node = null
var target_attacked: Node = null
	
func initialize(body: Node) -> void:
	main_target = body
	current_target = body
	healthbar.init_health(health)
	
func _physics_process(delta):	
	var velocity = global_position.direction_to(current_target.global_position)
	var angle_to_target = global_position.direction_to(current_target.global_position).angle() - 80
	body_sprite.rotation = move_toward(body_sprite.rotation, angle_to_target, delta * 100)
	move_and_collide(velocity * speed * delta)
		
func on_body_entered_detection_area(body: Node) -> void:
	if current_target != main_target:
		return
		
	current_target = body
	
func on_body_leaved_detection_area(body: Node) -> void:
	if current_target == body:
		current_target = main_target
		
func notify_hit(damage_amount: float, hit_source : Vector2) -> void:
	
	animation_player.play("hit")
	
	health -= damage_amount
	healthbar.health = health
	audio_player.play()
	if health <= 0:
		queue_free()
		return
		
	var knockback_direcction= hit_source.direction_to(global_position)
	var knockback_position= knockback_direcction * knockback_multiplier
	global_position+=knockback_position

func _on_hitbox_body_entered(body: Node2D):
	if self.target_attacked == null and body != null:
		self.target_attacked = body
		attack_target()
		attack_rate.start()

func _on_hitbox_body_exited(body: Node2D):
	if self.target_attacked == body:
		self.target_attacked = null
		attack_rate.stop()

func attack_target():
	if (current_target.has_method("notify_hit")):
		self.current_target.notify_hit(damage_amount)
		
func enable_hit_flash() -> void:
	shader_material.set_shader_parameter("active", true)
	
func disable_hit_flash() -> void:
	shader_material.set_shader_parameter("active", false)
	


