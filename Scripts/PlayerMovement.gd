class PlayerMovement:

	const KEY_UP = "ui_up"
	const KEY_DOWN = "ui_down"
	const KEY_LEFT = "ui_left"
	const KEY_RIGHT = "ui_right"
	
	enum Facing {
		UP, DOWN, LEFT, RIGHT
	}
	
	func set_facing():
		
		var facing = Facing.DOWN
		
		if Input.is_action_pressed(KEY_UP): facing = Facing.UP
		if Input.is_action_pressed(KEY_DOWN): facing = Facing.DOWN
		if Input.is_action_pressed(KEY_LEFT): facing = Facing.LEFT
		if Input.is_action_pressed(KEY_RIGHT): facing = Facing.RIGHT
		
		print(facing)
		
		return facing
	
	func on_move():
		var move = Vector2();
		
		if Input.is_action_pressed(KEY_UP): move.y -= 1
		if Input.is_action_pressed(KEY_DOWN): move.y += 1
		if Input.is_action_pressed(KEY_LEFT): move.x -= 1
		if Input.is_action_pressed(KEY_RIGHT): move.x += 1
		
		return move
		
	func set_rotation():
		var rotd = 0
		
		if Input.is_action_pressed(KEY_UP): rotd = 180
		if Input.is_action_pressed(KEY_DOWN): rotd = 0
		if Input.is_action_pressed(KEY_LEFT): rotd = -90
		if Input.is_action_pressed(KEY_RIGHT): rotd = 90
		
		return rotd
	

