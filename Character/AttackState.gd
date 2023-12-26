extends State


class_name Attack

@export var return_state : State
@export var return_animation_node2 : String = "move"
@export var attack1_name : String = "attack1"
@export var attack2_name : String = "attack2"
@export var attack2_node : String = "attack2"


@onready var atk_timer = $AtkTimer

func state_input(event : InputEvent):
	if(event.is_action_pressed("attack")):
		#print("timer start")
		atk_timer.start()
		
#func state_process(delta):
	

func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == attack1_name):
		if(atk_timer.is_stopped()):
			#print("timer stop after 1 atk")
			next_state = return_state
			playback.travel(return_animation_node2)
		else:
			#print("timer still after 1 atk")
			playback.travel(attack2_node)
		
	if (anim_name == attack2_name):
		#print("after 2 atk")
		next_state = return_state
		playback.travel(return_animation_node2)
		



