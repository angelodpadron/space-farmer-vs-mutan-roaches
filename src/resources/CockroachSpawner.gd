extends Node2D

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().get_visible_rect().size
	var rand = RandomNumberGenerator.new()
	var enemyscene = load("res://src/entities/enemies/cockroach.tscn")
	var player = get_node("%Mouth")
	
	for i in range(0,10):
		var enemy = enemyscene.instantiate()
		add_child(enemy)
		var edge = randi() % 4
		match edge:
			0:
				# Arriba
				enemy.position = Vector2(randf() * screen_size.x, 0)
			1:
				# Abajo
				enemy.position = Vector2(randf() * screen_size.x, screen_size.y)
			2:
				# Izquierda
				enemy.position = Vector2(0, randf() * screen_size.y)
			3:
				# Derecha
				enemy.position = Vector2(screen_size.x, randf() * screen_size.y)
		
		enemy.initialize(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
