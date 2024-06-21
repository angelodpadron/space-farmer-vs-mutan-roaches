extends AbstractState

func enter() -> void:
	pass

func handle_input(event: InputEvent) -> void:
	pass
	
func update(delta: float) -> void:
	character._handle_move_input()
	if character.horizontal_dir != 0 or character.vertical_dir != 0:
		finished.emit("walk")

func handle_event(event: String, value = null) -> void:
	match event:
		"hit":
			character._handle_hit(value)
			if character.dead:
				finished.emit("dead")
