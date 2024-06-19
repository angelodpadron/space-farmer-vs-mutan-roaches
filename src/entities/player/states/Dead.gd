extends AbstractState


func enter() -> void:
	print("player state: dead")
	character._handle_dead()
	

func update(delta: float) -> void:
	pass
