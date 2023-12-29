extends Control

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

@onready var damageable = $"../Damageable"
@onready var progress_bar = $ProgressBar

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	progress_bar.value = damageable.health
