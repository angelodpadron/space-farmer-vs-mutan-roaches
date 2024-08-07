extends Area2D
class_name Plant

signal is_beign_picked_up

var speed: float = 500
var is_attracting: bool = false
var is_collectable: bool = false
var player_position

@onready var grow_timer: Timer = $GrowTimer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grow_timer.timeout.connect(grow)
	grow_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if is_attracting:
		var direction: Vector2 = (player_position - global_position).normalized()
		position += direction * speed * delta
		
		
func initialize(container: Node2D) -> void:
	container.call_deferred("add_child", self)
	
	
func grow() -> void:
	animated_sprite.play("grow")
	

func _on_detection_area_body_entered(player: Player):
	if is_collectable:
		player_position = player.position
		is_attracting = true
		is_beign_picked_up.emit()


func _on_detection_area_body_exited(_player):
	if not is_collectable:
		player_position = null


func _on_body_entered(player: Player) -> void:
	if is_collectable:
		player.add_crop()
		queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
	is_collectable = true


