extends Node2D

# TODO: FINISH IMPLEMENTATION :') 

@export var spawns: Array[SpawnInfo] = []

@onready var player: Player = $%Player

var time: int = 0


func spawn_enemies() -> void:	
	time += 1
	for spawn in spawns:
		if time >= spawn.time_start and time <= spawn.time_end:
			
			if spawn.spawn_delay_count < spawn.spawn_delay:
				spawn.spawn_delay_count += 1
				return
			
			spawn.spawn_delay_count = 0
			
			var new_enemy = load(str(spawn.enemy.resource_path))
			
			for count in (spawn.enemy_count):
				var enemy_spawn = new_enemy.instantiate()
				enemy_spawn.global_position = get_parent().global_position
				add_child(enemy_spawn)
				enemy_spawn.initialize(player)
