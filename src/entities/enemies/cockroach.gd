extends RigidBody2D

class_name Cockroach

@export var speed: float = 100
@onready var attack_rate: Timer = $AttackRate

var main_target: Node = null
var current_target: Node = null
var target_attacked: Node = null

var damage_amount = 10.0
	
func initialize(body: Node) -> void:
	main_target = body
	current_target = body
	
func _physics_process(delta):	
	var velocity = global_position.direction_to(current_target.global_position)
	move_and_collide(velocity * speed * delta)
		
func on_body_entered_detection_area(body: Node) -> void:
	if current_target != main_target:
		return
		
	print_debug("cockroach: found new target")
	current_target = body
	
func on_body_leaved_detection_area(body: Node) -> void:
	print_debug("cockroach: lost target, heading to main target")
	if current_target == body:
		current_target = main_target
		
func notify_hit() -> void:
	print_debug("cockroach: i've been shot!")
	queue_free()

func _on_hitbox_body_entered(body: Player):
	if self.target_attacked == null:
		self.target_attacked = body
		attack_rate.start()

func _on_hitbox_body_exited(body: Player):
	if self.target_attacked == body:
		self.target_attacked = null
		attack_rate.stop()

func attack_target():
	self.current_target.notify_hit(damage_amount)
	


