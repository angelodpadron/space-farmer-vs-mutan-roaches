extends CharacterBody2D

class_name Cockroach

@export var speed: float = 100
@export var damage_amount: int = 3

@onready var attack_rate: Timer = $AttackRate
@onready var body_sprite: Sprite2D = $Sprite2D


var main_target: HitboxComponent = null
var current_target: HitboxComponent = null
var target_attacked: HitboxComponent = null
	
func initialize(hitbox: HitboxComponent) -> void:
	main_target = hitbox
	current_target = hitbox
	
func _physics_process(delta):
	var velocity = global_position.direction_to(current_target.global_position)
	var angle_to_target = velocity.angle()
	
	# Ajusta el ángulo para que el sprite apunte con la cabeza
	var adjusted_angle = angle_to_target + PI / 2
	
	# Rota el sprite gradualmente hacia el ángulo ajustado
	body_sprite.rotation = move_toward(body_sprite.rotation, adjusted_angle, delta * 100)
	
	# Mueve el enemigo hacia el target
	move_and_collide(velocity * speed * delta)
		
		
func health_depleted() -> void:
	queue_free()


func attack_target():
	target_attacked.take_damage(damage_amount)


func _on_hitbox_area_entered(hitbox: HitboxComponent):
	print("hitbox component detected")
	if self.target_attacked == null:
		self.target_attacked = hitbox
		attack_rate.start()


func _on_hitbox_area_exited(area):
	if target_attacked == area:
		target_attacked = null
		attack_rate.stop()


func _on_detection_area_area_entered(hitbox: HitboxComponent):
	current_target = hitbox


func _on_detection_area_area_exited(hitbox: HitboxComponent):
	if current_target == hitbox:
		current_target = main_target


