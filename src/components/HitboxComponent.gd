extends Area2D
class_name HitboxComponent

signal damaged(amount: int)
signal damage

func take_damage(amount: int):
	damaged.emit(amount)
	damage.emit()
