extends State


class_name GroundState

@export var JUMP_VELOCITY = -250.0 #-150
@export var air_state : State
@export var jump_animation : String = "jump"

@export var dash_state : State
@export var DASH_VELOCITY = 1000.0 
@export var dash_animation : String = "dash"

var direction : Vector2 = Vector2.ZERO

@export var can_dash : bool = true
@onready var dash_timer = $"../Dash/DashTimer"



@export var attack_state : State
@export var attack_animation : String = "attack1"

@export var skill_state : State
@export var skill_animation : String = "skill"
@export var skill_animation2 : String = "skill2"
@export var skill_animation3 : String = "skill3"
@export var skill_animation4 : String = "skill4"

#@export var ultimate_state : State
#export var ultimate_animation : String = "ultimate"

@onready var damaging = $"../../Damaging"
@export var can_skill : bool = true

#@export var skillno : int = 0


func state_process(_delta):
	
	if(!character.is_on_floor()):
		next_state = air_state

func state_input(event : InputEvent):
	if(event.is_action_pressed("up")):
		jump()
		
		
	if(event.is_action_pressed("dash") && can_dash == true):
		dash()
		
	if(event.is_action_pressed("attack")):
		attack()
	
	
		
	if(event.is_action_pressed("switchr") ):
		if Global.skill_switch_state < 3:
			Global.skill_switch_state += 1
		else:
			Global.skill_switch_state = 0
			
		#print(skillno)
		
	if(event.is_action_pressed("switchl") ):
		if Global.skill_switch_state > 0:
			Global.skill_switch_state -= 1
		else:
			Global.skill_switch_state = 3
			
		#print(skillno)
		
	if(event.is_action_pressed("skill") && can_skill == true && Global.skill_switch_state == 0):
		skill()
		
	if(event.is_action_pressed("skill") && can_skill == true && Global.skill_switch_state == 1):
		skill2()
	
	if(event.is_action_pressed("skill") && can_skill == true && Global.skill_switch_state == 2):
		skill3()
		
	if(event.is_action_pressed("skill") && can_skill == true && Global.skill_switch_state == 3):
		skill4()
		
	#if(event.is_action_pressed("ultimate")):
	#	ultimate()
		


func dash():
	direction = Input.get_vector("left", "right", "up", "down")
	if (character.right == true && character.left == false):
		character.normal_speed = false
		character.velocity.x =  DASH_VELOCITY
	elif (character.right == false && character.left == true):
		character.normal_speed = false
		character.velocity.x =  -DASH_VELOCITY

		
	if (direction.x >0):
		character.velocity.x =  DASH_VELOCITY
	elif (direction.x <0):
		character.velocity.x =  -DASH_VELOCITY
	can_dash = false
	dash_timer.start()
	next_state = dash_state
	playback.travel(dash_animation)
	
func jump():
	character.velocity.y = JUMP_VELOCITY
	next_state = air_state
	playback.travel(jump_animation)
	
func attack():
	next_state = attack_state
	playback.travel(attack_animation)
	
func skill():
	damaging.damage = 3
	next_state = skill_state
	playback.travel(skill_animation)

func skill2():
	damaging.damage = 3
	next_state = skill_state
	playback.travel(skill_animation2)
	
func skill3():
	damaging.damage = 3
	next_state = skill_state
	playback.travel(skill_animation3)
	
func skill4():
	damaging.damage = 3
	next_state = skill_state
	playback.travel(skill_animation4)
	
#func ultimate():
#	damaging.damage = 3
#	next_state = ultimate_state
#	playback.travel(ultimate_animation)
	
