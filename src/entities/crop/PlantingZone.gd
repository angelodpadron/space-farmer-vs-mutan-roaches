extends StaticBody2D

@onready var grow_timer: Timer = $GrowTimer
@onready var plant: AnimatedSprite2D = $Plant
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

var plant_is_growing = false
var collectable = false


func _on_grow_timer_timeout():
	plant.play("grow")


func _on_area_2d_area_entered(area):
	if not plant_is_growing and not collectable:
		grow_timer.start()
		plant_is_growing=true


func _on_plant_animation_finished():
	collectable = true
	plant_is_growing = false


func _on_area_2d_body_entered(player: Player):
	if collectable:
		audio_player.play()
		player.add_crop()
		collectable = false
		plant.stop()
