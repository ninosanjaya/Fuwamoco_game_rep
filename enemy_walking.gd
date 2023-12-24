extends CharacterBody2D


var direction = Vector2.RIGHT
#var velocity = Vector2.ZERO #Godot 4 no need to put this line
@onready var ledgeCheckRight = $ledgecheckright
@onready var ledgeCheckLeft = $ledgecheckleft
@onready var animated_sprite_2d = $AnimatedSprite2D

#onready var ledgeCheckRight: = $LedgeCheckRight
#onready var ledgeCheckLeft: = $LedgeCheckLeft
#onready var sprite: = $AnimatedSprite

func _physics_process(delta):
	var found_wall = is_on_wall()
	var found_ledge = not ledgeCheckRight.is_colliding() or not ledgeCheckLeft.is_colliding()
	
	if found_wall or found_ledge:
		direction *= -1
	
	animated_sprite_2d.flip_h = direction.x > 0
	
	velocity = direction * 25
	move_and_slide()
