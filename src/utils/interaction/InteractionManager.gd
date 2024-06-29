extends Node2D

@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var label: Label = $Label

const base_text = "[SPACE] TO "

var active_areas = []
var can_interact = true

func register_area(area: InteractionArea) -> void:
	active_areas.push_back(area)
	
func unregister_area(area: InteractionArea) -> void:
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)
		
		
func _process(delta) -> void:
	if active_areas.size() > 0 and can_interact:
		var interactive_area: InteractionArea = active_areas[0]
		active_areas.sort_custom(_sort_by_distance_to_player)
		if interactive_area.can_interact:
			label.text = base_text + interactive_area.action_name
		else:
			label.text = interactive_area.action_name
		label.global_position = interactive_area.global_position
		label.global_position.y -= 36
		label.global_position.x -= label.size.x / 2	
		label.show()
	else:
		label.hide()


func _input(event):
	if event.is_action_pressed("interact") and can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call()

			can_interact = true
			
			
func _sort_by_distance_to_player(area1: InteractionArea, area2: InteractionArea) -> bool:
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	
	return area1_to_player < area2_to_player
	
