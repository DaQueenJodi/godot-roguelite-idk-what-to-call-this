extends Actor

func _physics_process(_delta: float) -> void:
	_handle_movement()
	_velocity = move_and_slide(_velocity)


func _handle_movement():
	var direction = _get_direction()
	_velocity = _get_velocity(direction)
	
func _get_velocity(direction):
	return Vector2(
		speed.x * direction.x,
		speed.y * direction.y
	)
	
	
func _get_direction():
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")	
	)
	
