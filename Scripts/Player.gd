extends KinematicBody2D

export var MOTION_SPEED = 140

const IDLE_SPEED = 10

var RayNode
var PlayerAnimNode
var anim = ""
var animNew = ""

# enums
enum KEYS { 
	UP
}

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
		
	
	if anim != animNew:
		animNew = anim
		PlayerAnimNode.play(anim);
	
	pass
