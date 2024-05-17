extends Node2D

class_name TurretProjectile

signal delete_requested(projectile)

@onready var hitbox: Area2D = $Hitbox
@export var velocity: float = 300

var direction: Vector2

func set_starting_value(container: Node, spawn_position: Vector2, direction: Vector2) -> void:
	container.add_child(self)
	self.direction = direction
	global_position = spawn_position
	
func _physics_process(delta: float) -> void:
	position += direction * velocity * delta

func _on_life_time_timeout():
	emit_signal("delete_requested", self)

func _on_hitbox_body_entered(body):
	if body.has_method("notify_hit"):
		body.notify_hit()
	emit_signal("delete_requested", self)
