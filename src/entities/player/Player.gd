extends CharacterBody2D

class_name Player

@export var speed:float = 1
@onready var crop_quantity:int = 0
@onready var forward:Vector2 = Vector2.DOWN
@onready var hitbox = $Hitbox
@onready var interactables:Array = []

# spawnables
const CROP_SCENE: PackedScene = preload("res://src/resources/crop/crop.tscn")
const TURRENT_SCENE: PackedScene = preload("res://src/resources/turret/turret.tscn")

var instancing_contaier = null

signal crop_collected

func _ready() -> void:
	initialize()

func initialize(instancing_contaier: Node = get_parent()) -> void:
	self.instancing_contaier = instancing_contaier

func _physics_process(delta):
	var horizontal_dir:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	var vertical_dir:int = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))

	var velocity:Vector2 = Vector2(horizontal_dir,vertical_dir).normalized() * speed

	if velocity != Vector2.ZERO:
		forward = velocity.normalized()
		#print_debug(velocity)
	
	set_velocity(velocity)
	move_and_slide()

func _process(delta):
	if Input.is_action_just_pressed("place_crop"):
		print_debug(forward)
		var crop_instance = CROP_SCENE.instantiate().initialize(instancing_contaier, hitbox.global_position + (forward * 20))
		print_debug(str("crop instantiated in: ", global_position + forward))
		
	if Input.is_action_just_pressed("place_turret"):
		_add_turret()
	if Input.is_action_just_pressed("collect_crop") and interactables:
		_add_crop()


func _add_crop():
	var cur_interaction = interactables[0]
	if cur_interaction.collectable:
		cur_interaction.collect(self)
		crop_quantity += 1
		emit_signal("crop_collected")

func _add_turret():
	var turret_instance = TURRENT_SCENE.instantiate().initialize(instancing_contaier, hitbox.global_position + (forward * 20))

func _on_interaction_area_interactable_entered(area:Crop):
	interactables.insert(0, area)

func _on_interaction_area_interactable_exited(area:Crop):
	interactables.erase(area)
