class_name Crop extends Area2D

@onready var collectable:bool=false
@onready var grow_timer = $"Grow Timer"
@onready var animation = $Animation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initialize(container:Node,spawn_position:Vector2)->void:
	container.add_child(self)
	global_position=spawn_position
	grow_timer.start()
	animation.play("grow")
	

func _on_grow_time_timeout():
	collectable=true
	

func collect(player:Player):
	if collectable==true:
		collectable=false
		queue_free()

