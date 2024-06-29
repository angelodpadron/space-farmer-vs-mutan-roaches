extends Resource

# Clase con detalles y reglas para cada tipo de enemigo a spawnear durante ronda
class_name SpawnInfo

@export var enemy: Resource
@export var enemy_count: int
@export var spawn_delay: int

var spawn_delay_count: int = 0


