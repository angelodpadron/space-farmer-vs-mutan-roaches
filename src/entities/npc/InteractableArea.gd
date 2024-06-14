extends Area2D

class_name Interactable

@export var interaction_delegate:Node

func interact(player:Player):
	interaction_delegate.interact(player)
