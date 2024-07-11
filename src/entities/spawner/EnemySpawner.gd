extends Node2D

@export var spawn_infos: Array[SpawnInfo] = []
@onready var ship: Ship = get_tree().get_first_node_in_group("ship")
@onready var spawn_timer: Timer = $SpawnTimer

var current_spawn_index: int = 0
var enemies_spawned: int = 0


func _ready() -> void:
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)


func spawn_enemies() -> void:	
	var spawn_info: SpawnInfo = spawn_infos[current_spawn_index]
	
	if enemies_spawned < spawn_info.enemy_count:
		
		# delay between each enemy spawned
		if spawn_info.spawn_delay_count < spawn_info.spawn_delay:
			spawn_info.spawn_delay_count += 1
			return
			
		spawn_info.spawn_delay_count = 0
		
		var new_enemy = load(str(spawn_info.enemy.resource_path))
		var enemy_instance: Cockroach = new_enemy.instantiate()
		add_child(enemy_instance)
		enemy_instance.global_position = get_parent().global_position
		enemy_instance.initialize(ship.hitbox_component)
		enemies_spawned += 1
	else:
		current_spawn_index += 1
		


func _on_mouth_rumble():
	spawn_timer.start()


func _on_spawn_timer_timeout() -> void:
	if current_spawn_index >= spawn_infos.size():
		spawn_timer.stop()
		return
	
	spawn_enemies()
	
