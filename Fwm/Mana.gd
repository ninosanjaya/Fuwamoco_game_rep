extends Control

@onready var progress_bar = $ProgressBar

#Notes:
#Mana full 100% (20%, 40%, 60%, 80%, 100%)
#Player can use skill at 40%, so at 100%, player can use skill 2x (but with cooldown 5s)
#when player hit enemy, player will get 10% mana
#There will be items with 50% & 100% mana

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	progress_bar.value = Global.mana_player_one 


#func _on_timer_timeout():
#	progress_bar.value += 1
