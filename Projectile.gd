extends CharacterBody2D


#var Speed = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const MOVE_SPEED = 200
var DD  = 1




func _ready():
	#velocity.x = MOVE_SPEED * DD
	pass
	
func _physic_process(_delta):
	#position.x += velocity.x * MOVE_SPEED * delta
	#velocity.y += gravity * delta
	#velocity.y = 100



	velocity.x = MOVE_SPEED * 1
	#velocity.x = Input.get_axis("ui_up", "ui_down") * transform.basis.z * speed
	move_and_slide()
	
func launch(_direction):
	pass
#	var temp = global_transform
#	var scene = get_tree().current_scene
#	get_parent().remove_child(self)
#	scene.add_child(self)
#	global_transform = temp
#	velocity.y = 100
#	if direction == true:
#		DD = 1
#		velocity.x = MOVE_SPEED * DD
#		print(velocity)
#	elif direction == false:
#		DD = -1
#		velocity.x = MOVE_SPEED * DD
#		print(velocity)
#	move_and_slide()

	

