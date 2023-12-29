extends Area2D


var entered = false



func _on_body_entered(body : Node2D):
	if (body is Player) or (body is Player2):
		entered = true


func _on_body_exited(_body):
	entered = false
	
func _process(_delta):
	if entered == true:
		if Input.is_action_just_pressed("attack"):
			get_tree().change_scene_to_file("res://world_3.tscn")
