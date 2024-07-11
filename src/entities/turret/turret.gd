class_name Turret
extends StaticBody2D

@export var PROJECTILE_SCENE: PackedScene
@onready var fire_position = $%FirePosition
@onready var fire_rate = $FireRate
@onready var health_bar = $HealthBar
@onready var audio_player = $ShootAudio
@onready var sprite: Sprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var target: Cockroach
var targets: Array[Cockroach]
var projectile_container: Node

func fire():
	audio_player.play()
	var projectile_instance: TurretProjectile = PROJECTILE_SCENE.instantiate()
	var spawn_position = fire_position.global_position
	var direction = (target.global_position - fire_position.global_position).normalized()
	
	projectile_instance.set_starting_value(projectile_container, spawn_position, direction)
	projectile_instance.delete_requested.connect(on_projectile_delete_request)

func initialize(container: Node, spawn_position: Vector2) -> void:
	container.add_child(self)
	projectile_container = container
	global_position = spawn_position
	
func _process(_delta):
	if target:
		var direction = (target.global_position - fire_position.global_position).normalized()
		sprite.rotation = lerp_angle(sprite.rotation, direction.angle(), 0.1)
	
func on_body_entered_detection_area(body: Cockroach) -> void:
	self.targets.append(body)
	if self.target == null:
		self.target = body
		fire_rate.start()

func on_body_leaved_detection_area(body: Cockroach) -> void:
	self.targets.erase(body)
	if self.target == body:
		if self.targets.size() > 0:
			self.target = self.targets.pick_random()
			return
		self.target = null
		fire_rate.stop()

func on_projectile_delete_request(projectile: TurretProjectile):
	projectile.delete_requested.disconnect(on_projectile_delete_request)
	projectile_container.call_deferred("remove_child",projectile)
	projectile.call_deferred("queue_free")
	

func _on_fire_rate_timeout():
	fire()
	
func enable_hit_flash() -> void:
	sprite.material.set_shader_parameter("active", true)
	
func disable_hit_flash() -> void:
	sprite.material.set_shader_parameter("active", false)


func _handle_dead():
	queue_free()
