extends Line2D

func connect_line(position_a, position_b):
	points = [position_a, position_b]
	


func _on_Player_line_drawned(position_a, position_b):
	connect_line(position_a, position_b)
	pass # Replace with function body.
