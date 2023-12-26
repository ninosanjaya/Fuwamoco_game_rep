extends Area2D

@export var damage : int = 2
@export var player : Player2
@export var facing_shape : FacingCollisionShape2D2

func _ready():
	monitoring = false
	player.connect("facing_direction_changed", _on_player_facing_direction_changed)


func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			var direction_to_damageable = (body.global_position - get_parent().global_position)
			var direction_sign = sign(direction_to_damageable.x)
			#print_debug(body.name + " took "+ str(damage) + ".")
			if (direction_sign > 0):
				child.hit(damage, Vector2.RIGHT)
			elif (direction_sign < 0):
				child.hit(damage, Vector2.LEFT)
			else:
				child.hit(damage, Vector2.ZERO)
			
			#child.hit(damage)
				
			
			
func _on_player_facing_direction_changed(facing_right : bool):
	if (facing_right):
		facing_shape.position = facing_shape.facing_right_position
	else:
		facing_shape.position = facing_shape.facing_left_position
