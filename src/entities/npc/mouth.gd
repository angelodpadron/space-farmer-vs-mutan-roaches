extends Node2D
class_name WorldMouth

signal rumble

@export var health: float = 10000
@export var first_wave_wait_time:int

@onready var health_bar: ProgressBar = $HealthBar
@onready var rumble_timer: Timer = $RumbleTimer
@onready var mouth_animation_player = $MouthAnimationPlayer
@onready var eating_time = $EatingTime

var rumble_count:int=1

func _ready():
	health_bar.init_health(health)
	rumble_timer.timeout.connect(demand_food)
	_play_animation("idle")
	

func notify_hit(damage_amount: float) -> void:
	health -= damage_amount
	health_bar.health = health

	if health <= 0:
		hide()

func demand_food() -> void:
	print_debug("mouth: feed me!")
	rumble_count*=2
	rumble.emit(rumble_count)
	_play_animation("rumble")
	rumble_timer.start(min(first_wave_wait_time/rumble_count,10))

func _play_animation(anim:String):
	mouth_animation_player.play(anim)


func _on_mouth_animation_player_animation_finished(anim_name):
	if anim_name=="rumble":
		_play_animation("idle")

func feed():
	rumble_timer.stop()
	_play_animation("chewing")
	eating_time.start(eating_time.time_left+1)

func _on_eating_time_timeout():
	eating_time.stop()
	_play_animation("idle")
	rumble_timer.start(first_wave_wait_time)
	
func interact(player:Player):
	print_debug("interacted with world")
	feed()
