extends Node2D

#@onready var cameraNode : Camera2D = get_node("Player/Camera2D")
@export var switch : float = 1
@export var switch_time : bool = true
#1 = player 1
#2 = player 2
@onready var P1 = get_node("Player")
@onready var P2 = get_node("Player2")
@onready var switch_timer = $SwitchTimer

var Pos1 : Vector2 

var save_path = "user://variable.save"
# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("Player2").get_parent().queue_free()
	#get_node("Player2").hide()
	#get_node("Player2").position = Vector2(-200,-200)
	#get_node("Player").show()

	#self.add_child(P1)
	#self.add_child(P2)
	self.remove_child(P2)
	P1.global_position = Vector2(-10,-10)
	#print(self.get_path())  # prints /root/Control/Node2D
	#print(P1.position)
	#print(P1.global_position)
	#self.remove_child(get_node("Player2"))
	#res://Character/player.tscn
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _process(_delta):
	#print(P1.position)
	#print(P1.global_position)
	#func _process(_delta):


	if Input.is_action_pressed("switchc") && switch == 1 && switch_time == true:
		#get_node("Player").get_parent().queue_free()
		#get_node("Player").position = Vector2(-100,-100)
		
		
		Pos1 = P1.global_position
		self.add_child(P2)
		self.remove_child(P1)

		#get_viewport().get_camera() = get_node("Player2/Camera2D2")
		
		P2.global_position = Pos1
		#get_node("Player2").position = Vector2(-100,-100)
		switch_timer.start()
		switch_time = false

		switch = 2
	
	elif Input.is_action_pressed("switchc") && switch == 2 && switch_time == true:
		
		Pos1 = P2.global_position
		self.add_child(P1)
		self.remove_child(P2)

		#get_viewport().get_camera() = get_node("Player2/Camera2D2")
		
		P1.global_position = Pos1
		#get_node("Player").position = Vector2(-100,-100)
		switch_timer.start()
		switch_time = false
		switch = 1
		
		


func _on_switch_timer_timeout():
	switch_time = true
	
	
func save(_file):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	#file.store_var(variable1)
	
func load_data(_file):
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		#variable1 = file.get_var(variable1)
	else:
		print("no data saved...")
		#variable1 = 0
