extends RigidBody2D

class_name Cockroach

signal died

@export var speed: float = 100

var main_target: Node = null
var current_target: Node = null
	
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
	set_physics_process(false)
	hide()
	collision_layer = 0
	emit_signal("died")
