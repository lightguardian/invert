extends KinematicBody2D

signal dimension_changed
signal sound_played(sound_fx)
signal sound_stoped(sound_fx)



const UP = Vector2(0, -1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 80
const JUMPFORCE = 270
const ACCELERATION = 10
var motion = Vector2()
var facing_right = true
var was_in_air = false
var is_falling = false

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

		if motion.y == 200:

			if $Timers/StartFalling.is_stopped():
				$Timers/StartFalling.start()
			
	

				
	motion = move_and_slide(motion,UP)
	
func _on_World_dimension_invert(color):

	invert(color)
	pass # Replace with  body.
	
func invert(color):
	emit_signal("sound_played","invert")
	modulate = Color(0,0,0) if color else Color(1,1,1)
	set_collision_mask_bit(1,color)
	set_collision_mask_bit(2,!color)

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
	pass # Replace with function body.
