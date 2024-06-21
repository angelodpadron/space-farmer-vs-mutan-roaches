extends Area2D

@export var plant_scene: PackedScene

var has_plant: bool = false


func _on_detection_area_area_entered(area: SeedpackHitbox):
	if has_plant:
		return
		
	var plant_instance: Plant = plant_scene.instantiate()
	plant_instance.initialize(self)
	plant_instance.is_beign_picked_up.connect(on_plant_picked_up)
	has_plant = true
	

func on_plant_picked_up() -> void:
	has_plant = false
