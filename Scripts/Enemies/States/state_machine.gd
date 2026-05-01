extends Node

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			var state : State = child
			states[state.name.to_lower()] = state
			state.Transitioned.connect(on_child_transition)
	
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Phyisics_Update(delta)

#Método que recebe os sinais dos states, executando a lógica transição entre cada estado.
#Deve receber como parâmetro o state que o chamou e o nome do state que se deseja transicionar para
func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state : State = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	
	current_state = new_state
