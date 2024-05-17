extends RigidBody2D

class_name Cockroach

@export var speed: float = 100

var target: Node = null
	
func _physics_process(delta):
	if target:
		var velocity = global_position.direction_to(target.global_position)
		move_and_collide(velocity * speed * delta)
		
func on_body_entered_detection_area(body: Node) -> void:
	print_debug("cockroach: new target entered to detection area")
	if body.name == "Player":
		target = body
	
func on_body_leaved_detection_area(body: Node) -> void:
	if body.name == "Player":
		print_debug("cockroach: target leaved detection area")
		target = null
