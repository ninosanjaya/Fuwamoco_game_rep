extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var DD = 1
@onready var timer = $Timer

func _ready():
	#velocity.x = SPEED * 1
	pass
	
func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	velocity.y = 0

	# Handle Jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)

	#
	
	#velocity.y += gravity * delta
	#velocity.y = 100

	#velocity.x = SPEED * 1
	move_and_slide()
	
func launch(direction):
	var temp = global_transform
	var scene = get_tree().current_scene
	get_parent().remove_child(self)
	scene.add_child(self)
	global_transform = temp
	velocity.y = 100
	if direction == true:
		DD = -1
		velocity.x = SPEED * DD
		#print(velocity)
	elif direction == false:
		DD = 1
		velocity.x = SPEED * DD
		#print(velocity)
	timer.start()
	move_and_slide()




func _on_timer_timeout():
	
	queue_free()
