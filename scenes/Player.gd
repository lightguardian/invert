extends KinematicBody2D

signal dimension_changed

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 80
const JUMPFORCE = 270
const ACCELERATION = 10
var motion = Vector2()
var facing_right = true
var was_in_air = false





# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func _physics_process(delta):
	
	motion.y += GRAVITY
	
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
		
	if facing_right == true:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1		
	
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	

		
	
	actions()
	
	

func actions():
	
	if Input.is_action_just_pressed("change"):
		emit_signal("dimension_changed")

		

		
	
	if Input.is_action_pressed("right"):
		motion.x += ACCELERATION
		facing_right = true
		if !was_in_air:
			if !is_on_wall():
				$AnimationPlayer.play("Run")
			else:
				$AnimationPlayer.play("Idle")	
	elif Input.is_action_pressed("left"):
		motion.x -= ACCELERATION
		facing_right = false
		if !was_in_air:
			if !is_on_wall():
				$AnimationPlayer.play("Run")
			else:
				$AnimationPlayer.play("Idle")			
	else:
		motion.x = lerp(motion.x,0,0.2)
		if !was_in_air:
			$AnimationPlayer.play("Idle")	

	
	if is_on_floor(): 
		
		if was_in_air:
			$AnimationPlayer.play("Splash")
			
		if Input.is_action_pressed("jump"):
			motion.y = -JUMPFORCE
			was_in_air = true
	if !is_on_floor():		
		
		if motion.y < 0:
			$AnimationPlayer.play("Jump")
			was_in_air = true
		elif motion.y > 190:
			$AnimationPlayer.play("Fall")
			was_in_air = true

				
	motion = move_and_slide(motion,UP)
	
	print(motion.y)

	
	
	
func _on_World_dimension_invert(color):

	invert(color)
	pass # Replace with  body.
	
func invert(color):
	modulate = Color(0,0,0) if color else Color(1,1,1)
	set_collision_mask_bit(1,color)
	set_collision_mask_bit(2,!color)	


func _on_AnimationPlayer_animation_finished(anim_name):
	print(anim_name)
	was_in_air = false
	pass # Replace with function body.


func _on_AnimationPlayer_animation_started(anim_name):

	pass # Replace with function body.
