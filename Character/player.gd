extends CharacterBody2D

class_name Player

#idle
#run/walk
#jump
#dash
#attack
#skill
#ultimate & switchable also
#switch character


@export var SPEED = 100.0
@export var ACCELERATION = 800.0
@export var FRICTION = 1000.0

@export var air_resistance = 200.0
@export var air_acceleration = 400.0


#var air_jump = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite_2d = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

var direction : Vector2 = Vector2.ZERO
signal facing_direction_changed(facing_right : bool)

#@onready var cameraNode : Camera2D = get_node("/root/World/Camera2D")
#@onready var cameraNode2 : Camera2D = get_node("/root/World2/Camera2D2")

#@export var health_player : float = 3
@export var normal_speed : bool = true
@export var right : bool = false
@export var left : bool = false

@onready var enemy = get_parent().get_node("Enemy_walking")
@onready var knock_timer = $KnockTimer


func _ready():
	animation_tree.active = true
	#print(enemy.knockback)
	#print(health_player)
	#cameraNode.current = true

	
#func _process(delta):
#	if cameraNode != null:
#		cameraNode.position = position
#	else:
		#cameraNode.current = not cameraNode.current
		#cameraNode2.current = true
#		cameraNode2.position = position
	
func _physics_process(delta):
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
		
		velocity.y = -30
		knock_timer.start()
#TODO: Fix Knockback ################################################################################################

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
#	handle_attack()
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

func death():
	if Global.health_player_one < 0:
		position = Vector2(-100,-100)
		Global.health_player_one = 3
	

func _on_knock_timer_timeout():
	enemy.knockback = false
	velocity.y += gravity 
