extends State


@export var walk2_state : State
@export var walk2_animation : String = "walk_v2"
@export var damageable : Damageable
@onready var enemy_walking = $"../.."

func _on_animation_tree_animation_finished(_anim_name):
	#damageable.health = 3
	enemy_walking.walk22 = true
	next_state = walk2_state
	playback.travel(walk2_animation)
	
