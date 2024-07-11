extends Node

@onready var player: Player = $%Player
@onready var ship: Ship = $%Ship
@onready var seedpack: Seedpack = $%Seedpack

@onready var game_over_screen = $%GameOver

func _ready():
	player.died.connect(_handle_player_dead)
	
	ship.died.connect(_handle_ship_died)
	ship.aboard.connect(_handle_aboard)
	ship.ready_to_generate_fuel.connect(_handle_ship_ready_to_generate_fuel)
	ship.generating_fuel.connect(_handle_ship_generating_fuel)
	ship.is_ready_to_go.connect(_handle_ship_ready_to_go)
	
	seedpack.picked_up.connect(_handle_seedpack_picked_up)
	

func _handle_player_dead() -> void:
	game_over_screen.show_with_title("You died")
	

func _handle_ship_died() -> void:
	game_over_screen.show_with_title("The ship is destroyed")


func _handle_aboard() -> void:
	game_over_screen.show_with_title("You escaped :D")
	
	
func _handle_seedpack_picked_up() -> void:
	Global.handle_objective_event("seedpack_picked_up")
	

func _handle_ship_generating_fuel() -> void:
	Global.handle_objective_event("generating_fuel")
	

func _handle_ship_ready_to_generate_fuel() -> void:
	Global.handle_objective_event("ready_to_generate_fuel")
	

func _handle_ship_ready_to_go() -> void:
	Global.handle_objective_event("ready_to_go")
