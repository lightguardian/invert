extends KinematicBody2D

var Grid = load("res://src/util/Grid.gd")

signal dimension_changed
signal sound_played(sound_fx)
signal sound_stoped(sound_fx)
signal scanned(node_position, size_cell, type)



const UP = Vector2(0, -1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 80
const JUMPFORCE = 270
const ACCELERATION = 10
const SNAP = 16



var motion = Vector2()
var facing_right = true
var was_in_air = false
var is_falling = false
var inside = false setget set_inside, get_inside
var gravity_points = []
var nearest_point 
var current_cell


var initial_position 
var global_color

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = position
	pass # Replace with function body.


func _init():
	Grid = Grid.new()


func _physics_process(delta):
	
	#Util.cross_scan(position, SNAP)

	if Input.is_action_just_pressed("reset"):
		reset()
	
	motion.y += GRAVITY
	
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
		
	if facing_right == true:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1		
	
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	if !inside:
		actions()
	
	# Player position
	set_label_position(position)
	
	# Debug]

	
	if get_inside():
		motion = Vector2(0,0)
		pass	

	

	
	

func actions():
	
	if Input.is_action_just_pressed("change"):
		emit_signal("dimension_changed")
		pass

	if Input.is_action_pressed("right"):
		motion.x += ACCELERATION
		facing_right = true
		if !was_in_air and !is_falling:
			if !is_on_wall():
				$AnimationPlayer.play("Run")
			else:
				$AnimationPlayer.play("Push")	
	elif Input.is_action_pressed("left"):
		motion.x -= ACCELERATION
		facing_right = false
		if !was_in_air and !is_falling:
			if !is_on_wall():
				$AnimationPlayer.play("Run")
			else:
				$AnimationPlayer.play("Push")			
	else:
		motion.x = lerp(motion.x,0,0.2)
		if !was_in_air and !is_falling:
			$AnimationPlayer.play("Idle")	
			

	
	if is_on_floor(): 
		was_in_air = false		
		$Timers/StartFalling.stop()	
		
		if is_falling:		
			$AnimationPlayer.play("Splash")


	

		if Input.is_action_pressed("jump"):

			emit_signal("sound_played","jump")
			$AnimationPlayer.play("Jump")
			motion.y = -JUMPFORCE
			was_in_air = true
			is_falling = false
			

	if !is_on_floor():		

		was_in_air = true

		if motion.y < MAXFALLSPEED:

			if $Timers/StartFalling.is_stopped():
				$Timers/StartFalling.start()
			
	

					
	motion = move_and_slide(motion,UP)



func change_label_color(color):
#	for i in $Labels.get_children():
#
#		for j in i.get_children():
#
#			j.modulate = Color(1,1,1)
	pass
				
	
		
func _on_World_dimension_invert(color):
	global_color = color
	invert(color)
	pass # Replace with  body.

func get_color(color):
	return Color(0,0,0) if color else Color(1,1,1)
		
func set_label_position(position):
	$Labels/position.text = "X: %d Y: %d" % [position.x, position.y]
	
func reset():
	position = initial_position	
			
func invert(color):
	emit_signal("sound_played","invert")
	modulate = get_color(color)
	change_label_color(color)
	invert_collision(self,color)
	invert_collision($Area2D,color)
	# Area Collision
	
func invert_collision(node,color):
	node.set_collision_mask_bit(1,color)
	node.set_collision_mask_bit(2,!color)


	
func play_once(current_animation, animation,  sound):
	
	if current_animation == animation:
		emit_signal("sound_played",sound)
	else:
		emit_signal("sound_stoped",sound)
		

func _on_AnimationPlayer_animation_started(anim_name):
	play_once(anim_name, "Fall", "falling")
	play_once(anim_name, "Splash", "splash")
	
		

func _on_AnimationPlayer_animation_finished(anim_name):
	
	if anim_name == "Splash":
		is_falling = false
		was_in_air = false
		
	

	



func _on_Fall_timeout():
	$AnimationPlayer.play("Fall")
	is_falling = true
	$Timers/StartFalling.stop()	

	pass # Replace with function body.
func get_quadrant(current_position, cell_size):
	var aux_x = floor(current_position.x /cell_size)
	var aux_y = floor(current_position.y /cell_size)
	
	return {x = aux_x, y = aux_y}
	
	

	
	
	
	
	
	
func toggle_collision(state):
	
	for i in range(1,3): 

		set_collision_mask_bit(i,state)
	
func get_nearest(nodes):
	var nearest_node
	if !nodes.empty():
		nearest_node = nodes[0]
		
	
	for i in nodes:
		if position.distance_to(i.position) < position.distance_to(nearest_node.position):
			nearest_node = i

	return nearest_node

func get_inside():
	return inside
func set_inside(value):
	inside = value
	

	
	

func _on_Area2D_body_entered(body):
	
	set_inside(true)
	
	
	emit_signal("scanned", position, SNAP, "CROSS")





	
	

	
	
	pass # Replace with function body.


func _on_Area2D_body_exited(body):


	
	
	pass # Replace with function body.


func _on_World_gravity_points_sended(gravity_points):
	self.gravity_points = gravity_points
	pass # Replace with function body.




func _on_Checker_scan_finished(find, pos):
	if find:
		position = pos
		inside = false

	pass # Replace with function body.
