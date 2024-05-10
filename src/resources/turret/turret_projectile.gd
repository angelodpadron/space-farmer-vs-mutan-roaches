extends Node2D

@onready var hitbox: Area2D = $Hitbox
@export var velocity: float = 100

var direction: Vector2

func initialize(container: Node, spawn_position: Vector2, direction: Vector2) -> void:
	container.add_child(self)
	self.direction = direction
	global_position = spawn_position
	
func _physics_process(delta: float) -> void:
	position += direction * velocity * delta
