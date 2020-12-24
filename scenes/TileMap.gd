extends TileMap



func _ready():
	modulate = Color(1,1,1)
	

func _on_Player_dimension_changed(color):
	
	if color:
		modulate = Color()
		
	pass # Replace with function body.
