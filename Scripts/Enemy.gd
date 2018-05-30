extends KinematicBody2D

export var MOTION_SPEED = 140



func _ready():
	
	set_physics_process(true)
	
	
	
	pass

func _physics_process(delta):
	
	var move = Vector2();
	var body = get_node("Body").get_overlapping_bodies(); 
	
	if body.size() != 0:
		for side in body:
#			if side.is_in_group("Player"):
			if side.get_name() == "Player":
				print(side.get_name() + " x : " + str(side.get_global_transform().x) + " : " + str(self.get_global_transform().x))
				print(side.get_name() + " y : " + str(side.get_global_transform().y) + " : " + str(self.get_global_transform().y))
				if side.get_global_transform().x < self.get_global_transform().x:
					move.x -= 10
					
	move = move.normalized() * MOTION_SPEED * delta
	move_and_slide(move)
	
	pass