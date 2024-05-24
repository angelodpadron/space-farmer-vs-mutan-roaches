extends Resource

# Clase con detalles y reglas para cada tipo de enemigo a spawnear durante ronda
class_name SpawnInfo

@export var enemy: Resource
@export var enemy_count: int
@export var time_start: int
@export var time_end: int
@export var spawn_delay: int

var spawn_delay_count: int

