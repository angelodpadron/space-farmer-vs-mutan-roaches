class_name Crop extends Area2D

@onready var collectable:bool = false
@onready var grow_timer = $"Grow Timer"
@onready var animation = $Animation

func initialize(container:Node, spawn_position:Vector2) -> void:
	container.add_child(self)
	global_position=spawn_position
	grow_timer.start()
	animation.play("grow")	

func _on_grow_time_timeout():
	collectable = true	

func collect(player: Player):
	if collectable:
		collectable = false
		queue_free()

