extends AbstractState

func enter() -> void:
	pass
	
	
func handle_input(_event: InputEvent) -> void:
	pass
	
	
func update(_delta: float) -> void:
	character._handle_move_input()
	if character.horizontal_dir != 0 or character.vertical_dir != 0:
		finished.emit("walk")


func handle_event(event: String, _value = null) -> void:
	match event:
		"dead":
			finished.emit("dead")
