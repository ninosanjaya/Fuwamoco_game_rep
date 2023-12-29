extends State


class_name HitState

@export var damageable : Damageable
@export var dead_animation : String = "dead_v2"
@export var dead_state : State
@export var knockback_speed : float = 100.00
@export var return_state : State
@onready var timer : Timer = $Timer
@onready var dead = $"../Dead"

func _ready():
	damageable.connect("on_hit", on_damageable_hit)
	damageable.connect("on_hit2", on_damageable_hit2)
	
func on_enter():
	#character.velocity = knockback_velocity
	timer.start()
	
func on_damageable_hit(_node: Node, _damage_amount: int, knockback_direction : Vector2):
	if(damageable.health > 0):
		character.velocity = knockback_speed * knockback_direction
		#print(character.velocity)
		emit_signal("interrupt_state", self)
	else:
		damageable.dead1 = true
		damageable.health = 5
		#print(character.velocity)
		emit_signal("interrupt_state", dead_state)
		playback.travel(dead_animation)
		
	if Global.mana_player_one < 100:
		Global.mana_player_one += 10
	else:
		Global.mana_player_one = 100
		
func on_damageable_hit2(_node: Node, _damage_amount: int, knockback_direction : Vector2):
	Global.mana_player_one += 10
	if(damageable.health > 0):
		character.velocity = knockback_speed * knockback_direction
		#print(character.velocity)
		emit_signal("interrupt_state", self)
	else:
		damageable.health = 5
		#print(character.velocity)
		emit_signal("interrupt_state", dead_state)
		playback.travel(dead_animation)
		
	if Global.mana_player_one < 100:
		Global.mana_player_one += 10
	else:
		Global.mana_player_one = 100
		
func on_exit():
	character.velocity = Vector2.ZERO
	


func _on_timer_timeout(): #for knockback
	next_state = return_state
