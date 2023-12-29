extends CharacterBody2D

class_name Player2

@export var SPEED = 200.0
@export var ACCELERATION = 900.0
@export var FRICTION = 1000.0

@export var air_resistance = 200.0
@export var air_acceleration = 500.0



#var air_jump = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite_2d = $Sprite2D2
@onready var animation_tree : AnimationTree = $AnimationTree2
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine2



var direction : Vector2 = Vector2.ZERO
signal facing_direction_changed(facing_right : bool)

#@onready var cameraNode : Camera2D = get_node("/root/World/Camera2D")
#@onready var cameraNode2 : Camera2D = get_node("/root/World2/Camera2D2")

@export var normal_speed : bool = true
@export var right : bool = true
@export var left : bool = false

@onready var player = get_parent().get_node("Player")

@onready var Projectile = preload("res://Projectiles2.tscn")
var held_item = null
signal throw_item()
@onready var held_item_position = $Sprite2D2/HeldItemPosition



@export var attack_state : State
@export var attack_animation : String = "attack1"
@onready var playback:AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")
@onready var attack_timer_ppp = $AttackTimerPPP
@export var can_attack2 : bool = true

#@onready var player_2 = $"../.."
#@onready var facing = player_2.right #true is right

@onready var enemy = get_parent().get_node("Enemy_walking")
@onready var knock_timer = $KnockTimer
var knockback = Vector2.ZERO
@export var hit_animation : String = "hit"
@export var hit_state : State

const whiten_duration = 0.15
#@export var whiten_material : ShaderMaterial 
@export var whiten_material : ShaderMaterial

func _ready():
	animation_tree.active = true
	#print(player.health_player)
	#cameraNode.current = true

#func _process(delta):
#	if cameraNode != null:
#		cameraNode.position = position
#	else:
		#cameraNode.current = not cameraNode.current
		#cameraNode2.current = true
#		cameraNode2.position = position
		

	
func _physics_process(delta):
	#print(direction)
	var input_axis = Input.get_axis("left", "right")
	direction = Input.get_vector("left", "right", "up", "down")
	# Control whether to move or not to move
	apply_gravity(delta)
#	handle_jump()
#	handle_acceleration(input_axis, delta)
#	handle_air_acceleration(input_axis,delta)
	apply_air_resistance(input_axis, delta)
	apply_friction(input_axis,delta)
	
	if direction.x != 0 && state_machine.check_if_can_move() && normal_speed == true:
		velocity.x = direction.x * SPEED
		
	#elif direction.x != 0 && state_machine.check_if_can_move() && Input.is_action_pressed("dash") :
	#	velocity.x = direction.x * DASH_VELOCITY
	#	ground_state.can_dash = false
	#	next_state = dash_state
	#	playback.travel(dash_animation)

	elif enemy.knockback == true:
		
		whiten_material.set_shader_parameter("whiten", true)
		#await $Timer.timeout
		await get_tree().create_timer(0.2).timeout
		whiten_material.set_shader_parameter("whiten", false)
		velocity = direction * SPEED + knockback
		knock_timer.start()
		knockback = lerp(knockback, Vector2.ZERO, 0.1)
		state_machine.current_state = hit_state
		playback.travel(hit_animation)
		enemy.knockback = false
		
		


	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	handle_atk()
	move_and_slide()
	update_animations(input_axis)
	update_facing_direction()
	death()
	
	# Add the gravity.
func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	
		
		
func apply_friction(input_axis, delta):
	if input_axis == 0:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
func apply_air_resistance(input_axis, delta):
	if input_axis == 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, air_resistance *delta)
		

		

func update_animations(_input_axis):
	animation_tree.set("parameters/move/blend_position", direction.x)
	


func update_facing_direction():
	if direction.x > 0:
		sprite_2d.flip_h = false
		right = true
		left = false
		
	elif direction.x < 0:
		sprite_2d.flip_h = true
		left = true
		right = false
		
	emit_signal("facing_direction_changed", sprite_2d.flip_h)
#res://Character/player.tscn.
#get_node("../a_sibling_node")
func death(): 
	if Global.health_player_one == 0:
		position = Vector2(-100,-100)
		Global.health_player_one = 3

func handle_atk():
	if Input.is_action_pressed("attack") && can_attack2 == true :
		spawn_rock()
		state_machine.current_state = attack_state
		playback.travel(attack_animation)
		can_attack2 = false
		attack_timer_ppp.start()



func _on_knock_timer_timeout():
	enemy.knockback = false

func spawn_rock():
	if held_item == null:
		held_item = Projectile.instantiate()
		held_item_position.add_child(held_item)
		


func _on_throw_item():
	held_item.launch(sprite_2d.flip_h)
	held_item = null


func _on_attack_timer_ppp_timeout():
	can_attack2 = true
