extends Area2D

class_name InteractionArea

@export var action_name: String = "interact" : set = update_action_name

var can_interact: bool = true : set = update_can_interact

var interact: Callable = func():
	pass

func update_action_name(action: String) -> void:
	action_name = action
	
	
func update_can_interact(value: bool) -> void:
	can_interact = value
	
	
func _on_body_entered(_body):
	InteractionManager.register_area(self)


func _on_body_exited(_body):
	InteractionManager.unregister_area(self)
