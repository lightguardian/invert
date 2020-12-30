extends TileMap

		


func _on_World_dimension_invert(color):
	
	invert(color)
	pass # Replace with function body.
	

	
func invert(color):
	modulate = Color(1,1,1) if !color else Color(0,0,0,0)

	
