@tool
extends PanelContainer

@onready var input: Label = $%Input
@onready var action: Label = $%Action

@export var action_input: String: set = _set_action_input
		
@export var action_name: String: set = _set_action_name

func _ready() -> void:
	input.text = action_input
	action.text = action_name
	
func _set_action_input(input: String) -> void:
	action_input = input
	if Engine.is_editor_hint() && has_node("%Input"):
		$"%Input".text = input

func _set_action_name(name: String) -> void:
	action_name = name
	if Engine.is_editor_hint() && has_node("%Input"):
		$"%Action".text = name
