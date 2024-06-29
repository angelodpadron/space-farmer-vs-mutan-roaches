extends StaticBody2D
class_name WorldMouth

signal rumble

@export var first_wave_wait_time: int
@export var max_spawn_count: int = 10
@export var feed_add_time: int = 3

@onready var rumble_timer: Timer = $RumbleTimer
@onready var mouth_animation_player: AnimationPlayer = $MouthAnimationPlayer
@onready var eating_time:Timer = $EatingTime
@onready var interaction_area: InteractionArea = $InteractionArea

var rumble_count: int = 1

func _ready():
	add_to_group("mouths")
	Global.attack_mode_engaged.connect(demand_food)
	interaction_area.interact = Callable(self, "_on_interact")
	_play_animation("idle")
	

func demand_food() -> void:
	print("demand food")
	rumble_count *= 2
	rumble.emit()
	_play_animation("rumble")
	rumble_timer.start(min(first_wave_wait_time/rumble_count,max_spawn_count))


func _play_animation(anim: String):
	mouth_animation_player.play(anim)


func _on_mouth_animation_player_animation_finished(anim_name):
	if anim_name == "rumble":
		_play_animation("idle")


func feed():
	rumble_timer.stop()
	_play_animation("chewing")
	eating_time.start(eating_time.time_left+feed_add_time)


func _on_eating_time_timeout():
	eating_time.stop()
	_play_animation("idle")
	rumble_timer.start(first_wave_wait_time)
	
	
func _on_interact():
	if Global.player_crop_amount >= 2:
		feed()
		Global.decrease_crop_amount(2)
		return
		
	print("Not enough!")
