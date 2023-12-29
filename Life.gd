extends Control

@onready var heart = $Heart

var heart_size: int = 100
# Called when the node enters the scene tree for the first time.
#func _ready():
	#heart.expand_mode


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	heart.size.x = Global.health_player_one * heart_size
