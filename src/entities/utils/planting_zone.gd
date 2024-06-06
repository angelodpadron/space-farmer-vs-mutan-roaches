extends StaticBody2D

@onready var grow_timer: Timer = $GrowTimer
@onready var plant: AnimatedSprite2D = $Plant
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

var plant_is_growing = false
var collectable = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_grow_timer_timeout():
	plant.play("grow")


func _on_area_2d_area_entered(area):
	if not plant_is_growing and not collectable:
		grow_timer.start()


func _on_plant_animation_finished():
	plant_is_growing = false
	collectable = true
	print_debug("planting_zone: plan finished grow")


func _on_area_2d_body_entered(player: Player):
	print_debug("planting_zone: player entered growing area")
	if collectable:
		audio_player.play()
		player.add_crop()
		collectable = false
		plant.stop()
