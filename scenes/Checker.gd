extends Node2D

signal scan_finished(find, pos)

var Grid = load("res://src/util/Grid.gd")

var scan_mode
var snap 
var count = 0
var center_scan
var position_center

enum { NORTH, SOUTH, EAST, WEST}

var coordinates = {
	north = true,
	south = true,
	east = true,
	west = true,
}

var current_coordinate = NORTH

var scan_method = 0

func _ready():

	pass
	
func _init():
	
	Grid = Grid.new()	

	
func _physics_process(delta):
	




		

	print($RayCast2D.is_colliding())

	if scan_mode:

		if $RayCast2D.is_colliding():
			cross_scan(position_center, snap)
			print(position)
		else:
			scan_mode = false
			found(position, true)
			


		



		
			
			
	



func turn_collision():
		
	
	
	pass
		
func next_clockwise(coordinate):
	
	if coordinate == NORTH:
		return EAST
	elif coordinate == EAST:
		return SOUTH
	elif coordinate == SOUTH:
		return 	WEST
	else:
		return NORTH

	
	pass
			

func cross_scan(node_pos, size_cell: int):

	var aux_pos
	node_pos = Grid.get_center(node_pos, size_cell)

	
	if coordinates.north:
		aux_pos = Vector2(node_pos.x, node_pos.y - size_cell * count)
		coordinates.north = false
		print("norte")
	elif coordinates.south:
		aux_pos = Vector2(node_pos.x, node_pos.y + size_cell * count)
		coordinates.south = false
		print("sul")
	elif coordinates.east:
		print("leste")	
		aux_pos = Vector2(node_pos.x + size_cell * count, node_pos.y)
		coordinates.east = false	
	elif coordinates.west:
		aux_pos = Vector2(node_pos.x - size_cell * count, node_pos.y)		
		coordinates.west = false
		print("oeste")
	else:
		count += 1
		for i in coordinates:
			coordinates[i] = true
		aux_pos = position_center	
			
	position =  aux_pos
	
		

func found(pos: Vector2, is_empty: bool):
	scan_mode = false
	emit_signal("scan_finished",is_empty, pos)


func around_scan(node_position: Vector2, size_cell: int):
	
	pass
		
func match_scan(node_pos, cell, type):
	type = type.to_upper()

	match type:
		"CROSS":
			cross_scan(node_pos, cell)
		"AROUND":
			around_scan(node_pos, cell)	
		_:
			print("Without method!")	
		
func invert_collision(node,color):
	node.set_collision_mask_bit(1,color)
	node.set_collision_mask_bit(2,!color)
	node.set_collision_mask_bit(3,true)



func init_scan(pos: Vector2, cell):

	scan_mode = true
	position_center = Grid.get_center(pos, cell)
	position = position_center
	current_coordinate = WEST
	snap = cell

	count = 1

	
func _on_Player_scanned(node, cell, type):

	init_scan(node, cell)
		
	
	pass # Replace with function body.
	
	


func _on_World_dimension_invert(color):
	invert_collision($RayCast2D,color)
	

	

