extends Node2D


@export var hit_sound: AudioStream
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	audio_player.stream = hit_sound


func play_hit_sound():
	audio_player.play()


func _on_hitbox_component_damaged(amount):
	play_hit_sound()
