extends Label

@export var state_machine : CharacterStateMachine
@onready var character_state_machine_2 = $"../CharacterStateMachine2"

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = "State: " + character_state_machine_2.current_state.name
