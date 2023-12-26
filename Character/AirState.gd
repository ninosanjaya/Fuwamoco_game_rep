extends State


class_name AirState

@export var ground_state : State
@export var jump_animation : String = "jump"

@export var dash_state : State
@export var dash_animation : String = "dash"
@onready var dash_timer = $"../Dash/DashTimer"

var has_double_jumped = false

func state_process(_delta):
	if(character.is_on_floor()):
		next_state = ground_state
		
func state_input(event : InputEvent):
	if (event.is_action_pressed("up") && !has_double_jumped):
		double_jump()		
		
	if(event.is_action_pressed("dash") && ground_state.can_dash == true):
		dash()
		

func on_exit():
	if (next_state == ground_state):
		has_double_jumped = false

func double_jump():
	character.velocity.y = ground_state.JUMP_VELOCITY # /2
	playback.travel(jump_animation)
	has_double_jumped = true
	
func dash():
	#direction = Input.get_vector("left", "right", "up", "down")
	if (character.right == true && character.left == false):
		character.normal_speed = false
		character.velocity.x =  ground_state.DASH_VELOCITY
	elif (character.right == false && character.left == true):
		character.normal_speed = false
		character.velocity.x =  -ground_state.DASH_VELOCITY

	ground_state.can_dash = false
	dash_timer.start()
	next_state = dash_state
	playback.travel(dash_animation)
	

