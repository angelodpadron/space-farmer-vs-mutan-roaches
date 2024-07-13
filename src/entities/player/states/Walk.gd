extends AbstractState


func enter() -> void:
	pass
	
	
func handle_input(event: InputEvent) -> void:
	pass
	

func update(delta: float) -> void:
	character._handle_move_input()
	character._apply_movement()
	
	
	if character.horizontal_dir == 0 and character.vertical_dir == 0:
		finished.emit("idle")
		
		
func handle_event(event: String, value = null) -> void:
	match event:
		"dead":
			finished.emit("dead")
