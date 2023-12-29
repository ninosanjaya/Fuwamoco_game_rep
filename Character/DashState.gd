extends State


class_name DashState

#@export var DASH_VELOCITY = 300.0 
@export var JUMP_VELOCITY = -200.0 #-150
@export var air_state : State
@export var ground_state : State
@export var jump_animation : String = "jump"
@export var return_animation_node : String = "move"




var direction : Vector2 = Vector2.ZERO

#func state_process(delta):
#	_on_dash_timer_timeout()
	
#func state_input(event : InputEvent):
#	if(event.is_action_pressed("up")):
#		jump()

		
	
#func jump():
#	character.velocity.y = JUMP_VELOCITY
#	ground_state.can_dash = true
#	next_state = air_state
#	playback.travel(jump_animation)

func _on_dash_timer_timeout():
	if (character.is_on_floor()):
		ground_state.can_dash = true
		character.normal_speed = true
		next_state = ground_state
		playback.travel(return_animation_node)
		
	elif(!character.is_on_floor()):
		ground_state.can_dash = true
		character.normal_speed = true
		next_state = air_state
		playback.travel(jump_animation)


#func _on_animation_tree_animation_finished(anim_name):
#	if (character.is_on_floor()):
#		ground_state.can_dash = true
#		next_state = ground_state
#		playback.travel(return_animation_node)
		
#	elif(!character.is_on_floor()):
#		ground_state.can_dash = true
#		next_state = air_state
#		playback.travel(return_animation_node)

