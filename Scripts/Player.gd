extends KinematicBody2D

export var MOTION_SPEED = 140

const IDLE_SPEED = 10

var RayNode
var PlayerAnimNode
var anim = ""
var animNew = ""
var attacked = false

# init
func _ready():
	
	# enable physics
	set_physics_process(true)
	
	# get raycast node used for turning sprites
	RayNode = get_node("RayCast2D")
	
	# animation node for animations
	PlayerAnimNode = get_node("AnimatedSprite")
	
	pass

func _physics_process(delta):
	
	# motion
	var motion = Vector2()

	if (Input.is_action_pressed("ui_accept")):
		attacked = true

	if !attacked:
		if (Input.is_action_pressed("ui_up")):
			motion.y -= 1
			RayNode.rotation_degrees = 180
		if (Input.is_action_pressed("ui_down")):
			motion.y += 1
			RayNode.rotation_degrees = 0
		if (Input.is_action_pressed("ui_left")):
			motion.x -= 1
			RayNode.rotation_degrees = -90
		if (Input.is_action_pressed("ui_right")):
			motion.x += 1
			RayNode.rotation_degrees = 90
			
		motion = motion.normalized() * MOTION_SPEED
	
		move_and_slide(motion)
		
		# animations
		if motion.length() > IDLE_SPEED * 0.09:
			if (Input.is_action_pressed("ui_up")):
				anim = "walk_up"
			if (Input.is_action_pressed("ui_down")):
				anim = "walk_down"
			if (Input.is_action_pressed("ui_left")):
				anim = "walk_left"
			if (Input.is_action_pressed("ui_right")):
				anim = "walk_right"
		else:
			if RayNode.rotation_degrees == 180:
				anim = "idle_up"
			if RayNode.rotation_degrees == 0:
				anim = "idle_down"
			if RayNode.rotation_degrees == -90:
				anim = "idle_left"
			if RayNode.rotation_degrees == 90:
				anim = "idle_right"
	else:
		if RayNode.rotation_degrees == 180:
			anim = "atk_down"
			motion.y -= 80
		if RayNode.rotation_degrees == 0:
			anim = "atk_down"
			motion.y += 80
		if RayNode.rotation_degrees == -90:
			anim = "atk_down"
			motion.x -= 80
		if RayNode.rotation_degrees == 90:
			anim = "atk_down"
			motion.x += 80

			
		atk_and_move_timer(delta, motion);
		
	if anim != animNew:
		animNew = anim
		PlayerAnimNode.play(anim);
	
	pass
	

#---- ATTACK TIMER -----

var elapsed_sec = 0
var max_sec = 0.35
func atk_and_move_timer(delta, motion):
	elapsed_sec += delta
	
	if elapsed_sec > (max_sec / 2) - 0.00 && elapsed_sec < (max_sec / 2) + 0.10:
		move_and_slide(motion * 4)
		
	if elapsed_sec > max_sec:
		elapsed_sec = 0
		attacked = false
	
	pass
	
#-----------------------
