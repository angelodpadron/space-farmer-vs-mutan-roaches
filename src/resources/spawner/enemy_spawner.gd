extends Node2D

@export var enemy_scene: PackedScene
@export var max_enemy_count = 5

# To test for now
@export var spawns: Array[SpawnInfo] = []

@onready var player: Node = $%Player
@onready var main_target: Node = $%Mouth

#var current_enemy_count = 0
var time = 0

func _ready():
	spawn_enemies()	

func spawn_enemies() -> void:
	time += 1
	for spawn in spawns:
		if time >= spawn.time_start and time <= spawn.time_end:
			if spawn.spawn_delay_count < spawn.spawn_delay:
				spawn.spawn_delay_count += 1
			else:
				spawn.spawn_delay_count = 0
				var new_enemy = load(str(spawn.enemy.resource_path))
				var counter = 0
				while counter < spawn.enemy_count:
					var enemy_spawn = new_enemy.instantiate()
					enemy_spawn.global_position = get_random_position()
					add_child(enemy_spawn)
					enemy_spawn.initialize(main_target)
					counter += 1
	
	#if current_enemy_count < max_enemy_count:
		#var enemy = enemy_scene.instantiate()
		#enemy.global_position = get_random_position()
		#add_child(enemy)
		#
		#enemy.initialize(main_target)
		#enemy.died.connect(_on_enemy_dead)
		#
		#current_enemy_count += 1

func get_random_position():
	var vpr = get_viewport_rect().size * randf_range(1.1, 1.4)
	var top_left = Vector2(player.global_position.x - vpr.x / 2, player.global_position.y - vpr.y/2)
	var top_right = Vector2(player.global_position.x + vpr.x / 2, player.global_position.y - vpr.y/2)
	var bottom_left = Vector2(player.global_position.x - vpr.x / 2, player.global_position.y + vpr.y/2)
	var bottom_right = Vector2(player.global_position.x + vpr.x / 2, player.global_position.y + vpr.y/2)
	var pos_side = ["up", "down", "left", "right"].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
			
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	
	return Vector2(x_spawn, y_spawn)

func _on_spawn_timer_timeout():
	spawn_enemies()

func _on_enemy_dead() -> void:
	pass
	#current_enemy_count -= 1
