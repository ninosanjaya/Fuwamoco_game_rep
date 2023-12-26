extends State



@export var return_state : State
@export var return_animation_node : String = "move"
@export var ultimate_name : String = "ultimate"





func _on_animation_tree_animation_finished(anim_name):	
	if (anim_name == ultimate_name):
		next_state = return_state
		playback.travel(return_animation_node)
		
