extends Node

class_name Damageable

signal on_hit(node : Node, damage_taken : int, knockback_direction : Vector2)
signal on_hit2(node : Node, damage_taken : int, knockback_direction : Vector2)

@export var health : float = 5
@export var dead1 : bool = false

func hit (damage : int, knockback_direction : Vector2):
	if dead1 == false:
		health -= damage
		emit_signal("on_hit", get_parent(),damage, knockback_direction)
	elif dead1 == true:
		health -= damage
		emit_signal("on_hit2", get_parent(),damage, knockback_direction)
	
	
	
	#if (health <= 0):
		
	#	get_parent().queue_free()
		
	
		
