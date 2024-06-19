extends AbstractStateMachine


func notify_hit(damage_amount: int) -> void:
	current_state.handle_event("hit", damage_amount)
