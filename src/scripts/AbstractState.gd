extends Node
class_name AbstractState

signal finished(next_state_name)

@export var state_id: String

var character: Node


func enter() -> void:
	return
	
func exit() -> void:
	return
	
func handle_input(_event: InputEvent) -> void:
	return
	
func handle_event(_event: String, value = null) -> void:
	return
	
func update(_delta: float) -> void:
	return

