class_name Turret

extends StaticBody2D

@export var PROJECTILE_SCENE: PackedScene
@onready var fire_position = $FirePosition
@onready var fire_rate = $FireRate

@onready var target:Node
var projectile_container:Node

func fire():
	var projectile_instance:TurretProjectile = PROJECTILE_SCENE.instantiate()
	projectile_instance.set_starting_value(projectile_container,fire_position.global_position, (target.global_position - fire_position.global_position).normalized())
	projectile_instance.delete_requested.connect(on_projectile_delete_request)

func initialize(container: Node, spawn_position: Vector2) -> void:
	container.add_child(self)
	projectile_container=container
	global_position = spawn_position
	

func on_body_entered_detection_area(body: Node) -> void:
	if self.target == null:
		self.target = body
		fire_rate.start()
		print_debug("++++++++++++entered turret range")

func on_body_leaved_detection_area(body: Node) -> void:
	if self.target == body:
		self.target = null
		fire_rate.stop()
		print_debug("**************leaved from turret")

func on_projectile_delete_request(projectile:Node):
	projectile_container.remove_child(projectile)
	projectile.queue_free()


func _on_fire_rate_timeout():
	fire()
