extends CharacterBody2D

#idle
#run/walk
#jump
#dash
#attack
#skill
#ultimate & switchable also
#switch character


const SPEED = 100.0
const ACCELERATION = 800.0
const FRICTION = 1000.0
const JUMP_VELOCITY = -300.0
const air_resistance = 200.0
const air_acceleration = 400.0

const dashspeed = 20000.0
const dashlength = 1

@onready var dash_timer = $DashTimer
@onready var attack_timer = $AttackTimer


var air_jump = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite_2d = $AnimatedSprite2D


func _physics_process(delta):
	var input_axis = Input.get_axis("move_left", "move_right")
	apply_gravity(delta)
	handle_jump()
	handle_acceleration(input_axis, delta)
	handle_air_acceleration(input_axis,delta)
	apply_air_resistance(input_axis, delta)
	apply_friction(input_axis,delta)
	handle_attack()
	update_animations(input_axis)
	move_and_slide()
	
	# Add the gravity.
func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
func handle_jump():
	if is_on_floor(): air_jump = true
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
			
	elif not is_on_floor():
		if Input.is_action_just_released("jump") and velocity.y < JUMP_VELOCITY / 2:
			velocity.y = JUMP_VELOCITY / 2
		
		if Input.is_action_just_pressed("jump") and air_jump:
			velocity.y = JUMP_VELOCITY * 0.8
			air_jump = false 
			
			

var can_dash = true
	
func _on_dash_timer_timeout():
	#print("finish dash")
	can_dash = true
	#if input_axis != 0:
	#	velocity.x = move_toward(velocity.x, SPEED * input_axis, ACCELERATION * delta)

func handle_acceleration(input_axis, delta):
	if not is_on_floor(): return
	if Input.is_action_just_pressed("dash") and can_dash ==true:
			#print("dash")
			#dash.start_dash(dashlength)
			#if dash.is_dashing():
			dash_timer.start()
			#if dash_timer != _on_dash_timer_timeout():
				
			velocity.x = move_toward(velocity.x, dashspeed * input_axis, dashspeed * delta)
			#print("dashing")  
			can_dash = false
				
			#else:
			#	velocity.x = move_toward(velocity.x, SPEED * input_axis, ACCELERATION * delta)
	elif input_axis != 0:
			#if can_dash == false:
			#	velocity.x = move_toward(velocity.x, dashspeed * input_axis, dashspeed * delta)
			#else:
			velocity.x = move_toward(velocity.x, SPEED * input_axis, ACCELERATION * delta)
		
func handle_air_acceleration(input_axis, delta):
	if is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, SPEED * input_axis, air_acceleration * delta)
		
		
func apply_friction(input_axis, delta):
	if input_axis == 0:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
func apply_air_resistance(input_axis, delta):
	if input_axis == 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, air_resistance *delta)
		

var can_attack = true

func handle_attack():
	if Input.is_action_just_pressed("attack"):
		attack_timer.start()
		can_attack = false
		
func _on_attack_timer_timeout():
	can_attack = true
		
func update_animations(input_axis):
	
	if can_attack == false:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("attack")
	
	if can_dash == false and input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("dash")
	elif input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
	
	if not is_on_floor():
		animated_sprite_2d.play("jump")
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.







