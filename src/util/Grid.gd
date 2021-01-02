extends Node

class_name Grid



func get_center(init_position: Vector2, size: int):
	
	init_position = get_current_cell(init_position, size)
	
	return Vector2(init_position.x + size/2, init_position.y + size/2)


func get_current_cell(some_position: Vector2, cell_size: int):
	
	var aux_x = cell_size * floor(some_position.x / cell_size)
	var aux_y = cell_size * floor(some_position.y / cell_size)
	
	return Vector2(aux_x, aux_y)
	

	
	
		
