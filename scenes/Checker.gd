extends KinematicBody2D

signal scan_finished(find, pos)

var Grid = load("res://src/util/Grid.gd")

var scan_mode = false
var count = 1


enum { NORTH, SOUTH, EAST, WEST}

var coordinates = {
	north = false,
	south = false,
	east = false,
	west = false,
}

var current_coordinate = NORTH

var scan_method = 0

func _ready():
	pass
	
func _init():
	
	Grid = Grid.new()	
	
func _physics_process(delta):
	
	current_coordinate = next_clockwise(current_coordinate)
	
	
	if get_slide_count() > 0:
		print('fodeu')
	else:
		pass
		

	
	
	
	
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
		count += 1		
	
	pass
			

func cross_scan(node_pos, size_cell: int):
	scan_mode = true
	print(node_pos)
	scan_method = "CROSS"

	node_pos = Grid.get_center(node_pos, size_cell)
	position = node_pos

	


	if current_coordinate == NORTH:
		return Vector2(node_pos.x, node_pos.y - size_cell * count)
	elif current_coordinate == SOUTH:
		return Vector2(node_pos.x, node_pos.y + size_cell * count)
	elif current_coordinate == EAST:
		return 	Vector2(node_pos.x + size_cell * count, node_pos.y)
	else:
		return Vector2(node_pos.x - size_cell * count, node_pos.y)		
		
		
	
		
	
func found(pos: Vector2, empty: bool):
	emit_signal("scan_finished",pos, empty)
	return empty

func around_scan(node_position: Vector2, size_cell: int):
	
	pass
		
func match_scan(node_pos, cell, type):
	type = type.to_upper()
	$CollisionShape2D.disabled = false
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

func _on_Player_scanned(node, cell, type):
	match_scan(node, cell, type)
	
	
	
	
	pass # Replace with function body.
	
	


func _on_World_dimension_invert(color):
	invert_collision(self,color)
	pass # Replace with function body.


func _on_Checker_body_entered(body):

	pass # Replace with function body.
