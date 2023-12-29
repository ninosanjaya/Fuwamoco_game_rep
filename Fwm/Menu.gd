extends Control

#MAIN MENU 
#TODO: ################################################################################
#-Design characters sprite, enemies sprite, object sprite collectables (mana, health, key item gems, bones) & background 
#
#-Make levels/world scenes puzzles (obstacle, dog bone, button)
#-Program bosses & special enemies
#
#-1Make UI basics (add switch skill, key item/no inventory?)
# Menu UI (pause menu, option menu & load/save menu so no autosave?) 
#-Add NPC, dialogue, backstory, ending story stuff (no need for cutscene) 
#
#-Add audio, voices, sound, sfx
#-Program/add VFX/SFX, paralax effect background, effects stuff
#-Draw main menu thumbnail, draw other stuff
#-Make credits at the end add everyone
#-bug fixes & improvement stuff
#-?
#-Done
#
#Credits:
#Ninhydro Studio
#Nino Sanjaya
#?
#Godot 4.2
#######################################################################################


func _on_play_pressed():
	get_tree().change_scene_to_file("res://world.tscn")


func _on_option_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
