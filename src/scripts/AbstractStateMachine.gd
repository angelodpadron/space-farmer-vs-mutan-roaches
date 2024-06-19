extends Node
class_name AbstractStateMachine

signal state_changed(current_state)

@export var character_path: NodePath
var character: Player: set = set_character
@export var start_state: NodePath
@export var states: Array[NodePath]

var states_map = {}
var current_state: AbstractState = null
var active: bool = false: set = set_active

func _ready():
	set_active(false)
	call_deferred("_initialize")
	

func _physics_process(delta: float) -> void:
	current_state.update(delta)	


func set_character(_character: Player) -> void:
	character = _character
	
	if not start_state:
		start_state = get_child(0).get_path()
	
	for child in get_children():
		child.finished.connect(_change_state)
		child.character = character
	
	initialize(get_node(start_state))


func _initialize() -> void:
	for state_path in states:
		var state: AbstractState = get_node(state_path)
		states_map[state.state_id] = state
		
	if not character_path.is_empty():
		var _character: Node = get_node_or_null(character_path)
		if _character != null:
			character = _character

		
func _change_state(state_name: String) -> void:
	if not active:
		return
	current_state.exit()
	current_state = states_map[state_name]
	state_changed.emit(current_state)
	current_state.enter()


func set_active(_active: bool) -> void:
	active = _active
	set_physics_process(active)
	set_process_input(active)
	
	if not self.active:
		current_state = null


func initialize(start_state) -> void:
	set_active(true)
	current_state = start_state
	current_state.enter()
	
