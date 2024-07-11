extends StaticBody2D
class_name Seedpack

signal picked_up

var selected = false

var body

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready():
	interaction_area.interact = Callable(self, "on_interact")
	interaction_area.action_name = "pick up"
	animation_player.play("bounce")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if selected and body != null:
		global_position = lerp(global_position, body.global_position, 25 * delta)
		

func on_interact() -> void:
	selected = not selected
	
	match selected:
		true:
			picked_up.emit()
			interaction_area.action_name = "put down"
			animation_player.stop()
		_:
			interaction_area.action_name = "pick up"
			animation_player.play("bounce")


func _on_interaction_area_body_entered(body):
	if self.body == null:
		self.body = body


func _on_interaction_area_body_exited(body):
	if self.body == body:
		body = null
