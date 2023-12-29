extends State

@onready var enemy_walking = $"../.."

# Called when the node enters the scene tree for the first time.
func state_process(_delta):
	enemy_walking.walk22 = true
