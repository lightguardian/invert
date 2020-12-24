extends Node2D

signal dimension_invert(color)

var global_color = true;

func _ready():
	invert(global_color)
	emit_signal("dimension_invert", global_color)
	


func _on_Player_dimension_changed():
	global_color = !global_color
	invert(global_color)
	emit_signal("dimension_invert", global_color)

func invert(color):
	var color_bg = Color(0,0,0) if !color else Color(1,1,1)
	VisualServer.set_default_clear_color(color_bg)
	


func _on_World_dimension_invert(color):
	pass # Replace with function body.
