extends StaticBody2D

@export var PROJECTILE_SCENE: PackedScene

var target: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initialize(container: Node, spawn_position: Vector2) -> void:
	container.add_child(self)
	global_position = spawn_position
	

func on_body_entered_detection_area(body: Node) -> void:	
	if target == null and body.name == "Cockroach":
		target = body
		print_debug("turret: new target entered to detection area")

func on_body_leaved_detection_area(body: Node) -> void:
	if body == target:
		target = null
		print_debug("turret: target leaved detection area")
			
