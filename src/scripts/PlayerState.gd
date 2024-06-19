extends Node

var health: int = 100
var crop_amount: int = 0


func set_health(amount: int) -> void:
	health = amount

func decrease_health(amount: int) -> void:
	health -= amount
	
func increase_crop_amount(amount: int) -> void:
	crop_amount += amount
	
func decrease_crop_amount(amount: int) -> void:
	crop_amount -= amount

