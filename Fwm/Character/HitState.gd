extends State


class_name HitState1P

@export var ground_state : State
@export var return_animation : String = "move"

@export var air_state : State
@export var jump_animation : String = "jump"
@onready var knock_timer = $"../../KnockTimer"


#func state_process(_delta):
#	print(knock_timer.time_left)
#	if knock_timer.time_left == 0:
#		if(character.is_on_floor()):
#			next_state = ground_state
#			playback.travel(return_animation)
		
#		elif(!character.is_on_floor()):
#			next_state = air_state
#			playback.travel(jump_animation)

		

#func _on_animation_tree_animation_finished(anim_name):
#	if(character.is_on_floor()):
#		next_state = ground_state
#		playback.travel(return_animation)
		
#	elif(!character.is_on_floor()):
#		next_state = air_state
#		playback.travel(jump_animation)


func _on_knock_timer_timeout():
	if(character.is_on_floor()):
		next_state = ground_state
		playback.travel(return_animation)
		
	elif(!character.is_on_floor()):
		next_state = air_state
		playback.travel(jump_animation)
