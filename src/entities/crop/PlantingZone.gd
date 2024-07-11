extends Area2D

@export var plant_scene: PackedScene

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var arrow_sprite: Sprite2D = $ArrowSprite

var has_plant: bool = false

func _ready() -> void:
	animation_player.play("bounce")
	
func _process(_delta) -> void:
	if has_plant:
		arrow_sprite.hide()

func _on_detection_area_area_entered(area) -> void:
	
	if not (area is SeedpackHitbox):
		return
	
	if has_plant:
		return
		
	var plant_instance: Plant = plant_scene.instantiate()
	plant_instance.initialize(self)
	plant_instance.is_beign_picked_up.connect(_on_plant_picked_up)
	has_plant = true
	

func _on_plant_picked_up() -> void:
	has_plant = false
	arrow_sprite.show()
