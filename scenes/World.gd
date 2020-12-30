extends Node2D

signal dimension_invert(color)
signal gravity_points_sended(gravity_points)

var global_color = false;

func _ready():
	invert(global_color)
	emit_signal("dimension_invert", global_color)
	emit_signal("gravity_points_sended", get_gravity_points())
	
func get_gravity_points():
	return $GravityPoints.get_children()

	


func _on_Player_dimension_changed():
	global_color = !global_color
	invert(global_color)
	emit_signal("dimension_invert", global_color)

func invert(color):
	var color_bg = Color(0,0,0) if !color else Color(1,1,1)
	VisualServer.set_default_clear_color(color_bg)
	


func _on_World_dimension_invert(color):

	pass # Replace with function body.
	
