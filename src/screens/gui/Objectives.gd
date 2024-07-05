extends VBoxContainer

@onready var details: Label = $Details

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.objective_updated.connect(_update_objective_description)
	var objective_details = Global.get_current_objective()
	details.text = objective_details["description"]


func _update_objective_description(new_objective) -> void:
	details.text = new_objective["description"]
