extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print(self.get_path())  # prints /root/Control/Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
