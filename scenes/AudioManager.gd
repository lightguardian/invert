extends Node2D

onready var jump_fx = get_node("Fx/jump")
onready var invert_fx = get_node("Fx/invert")
onready var splash_fx = get_node("Fx/splash")
onready var falling_fx = get_node("Fx/falling")

enum Player{	
		JUMP,
		INVERT,
		SPLASH,
	}

func _on_Player_sound_played(sound_fx):
	

	if 	sound_fx == "splash" || sound_fx == "falling": 
		if !choose_sound(sound_fx).playing:
			choose_sound(sound_fx).play()
	else:
		choose_sound(sound_fx).play()	
	
	pass # Replace with function body.

func _on_Player_sound_stoped(sound_fx):
	
	choose_sound(sound_fx).stop()

	pass # Replace with function body.	

func choose_sound(name):
	match name:
		"jump":
			return jump_fx
		"invert":
			return invert_fx
		"splash":
			return splash_fx
		"falling":
			return falling_fx			
			
	


