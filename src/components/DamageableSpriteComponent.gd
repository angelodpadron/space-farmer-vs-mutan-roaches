extends Node2D

@export var hit_shader: Shader
@export var sprite: Node # can also be a animated sprite 2d

#@onready var sprite = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	if sprite == null:
		printerr("Error: No sprite was assigned to component")
		set_process(false)
		
	if not (sprite is AnimatedSprite2D or sprite is Sprite2D):
		printerr("Error: Need to provide either a Sprite2D or an AnimatedSprite2D")
		set_process(false)
		
	if hit_shader == null:
		printerr("Error: No hit shader was assigned to component")
		set_process(false)
		
	var shader_material = ShaderMaterial.new()
	shader_material.shader = hit_shader
	sprite.material = shader_material
	

func play_animation() -> void:
	animation_player.play("hit")

func enable_hit_flash() -> void:
	sprite.material.set_shader_parameter("active", true)
	
	
func disable_hit_flash() -> void:
	sprite.material.set_shader_parameter("active", false)


func _on_hitbox_component_damaged(amount):
	play_animation()
