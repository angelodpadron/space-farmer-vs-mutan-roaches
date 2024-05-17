extends RigidBody2D

class_name Cockroach

@export var speed: float = 100

var main_target: Node = null
var target: Node = null
	
func initialize(body: Node) -> void:
	main_target = body
	
func _physics_process(delta):
	
	# enemigo se mueve hacia target principal
	# si en su recorrido encuentra otro target, pasa a atacar a este hasta perderlo de vista
	# luego reanuda su carga hacia target principal
	
	if target:
		var velocity = global_position.direction_to(target.global_position)
		move_and_collide(velocity * speed * delta)
		return
	
	var velocity = global_position.direction_to(main_target.global_position)
	move_and_collide(velocity * speed * delta)
		
func on_body_entered_detection_area(body: Node) -> void:
	if body.name == "Player":
		print_debug("cockroach: detected player!")
		target = body
	if body.name == "Turret":
		print_debug("cockroach: detected turret!")
		target = body
	#if body.name == "Crop":
	print_debug("cockroach: detected crop")
	target = body
	
func on_body_leaved_detection_area(body: Node) -> void:
	if body.name == "Player":
		print_debug("cockroach: target leaved detection area")
		target = null
	if body.name == "Turret":
		print_debug("cockroach: target leaved detection area")
		target = null
	if body.name == "Crop":
		print_debug("cockroach: target leaved detection area")
		target = null
