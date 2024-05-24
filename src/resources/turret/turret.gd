class_name Turret

extends StaticBody2D

@export var PROJECTILE_SCENE: PackedScene
@onready var fire_position = $FirePosition
@onready var fire_rate = $FireRate
@onready var health_bar = $HealthBar

var target: Cockroach
var targets: Array[Cockroach]
var projectile_container: Node

var health: float = 50

func fire():
	var projectile_instance: TurretProjectile = PROJECTILE_SCENE.instantiate()
	var spawn_position = fire_position.global_position
	var direction = (target.global_position - fire_position.global_position).normalized()
	projectile_instance.set_starting_value(projectile_container, spawn_position, direction)
	projectile_instance.delete_requested.connect(on_projectile_delete_request)

func initialize(container: Node, spawn_position: Vector2) -> void:
	container.add_child(self)
	projectile_container = container
	global_position = spawn_position
	health_bar.init_health(health)
	
func on_body_entered_detection_area(body: Cockroach) -> void:
	self.targets.append(body)
	if self.target == null:
		self.target = body
		fire_rate.start()
		print_debug("turret: target aquired")

func on_body_leaved_detection_area(body: Cockroach) -> void:
	self.targets.erase(body)
	if self.target == body:
		print_debug("turret: target lost")
		if self.targets.size() > 0:
			self.target = self.targets.pick_random()
			print_debug("turret: switching target")
			return
		self.target = null
		fire_rate.stop()
		print_debug("turret: searching...")

func on_projectile_delete_request(projectile: TurretProjectile):
	projectile.delete_requested.disconnect(on_projectile_delete_request)
	projectile_container.call_deferred("remove_child",projectile)
	projectile.call_deferred("queue_free")
	
func notify_hit(damage_amount: float) -> void:
	print_debug("turret: damage")
	health -= damage_amount
	health_bar.health = health
	
	if health <= 0:
		queue_free()
	

func _on_fire_rate_timeout():
	fire()
