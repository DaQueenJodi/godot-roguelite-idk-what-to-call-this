extends Actor

onready var health_bar: = get_node("../HUD/HealthBar")


func take_damage(dmg: int) -> void:
	health -= dmg
	health_bar.update_health(health)
	if health <= 0:
		queue_free()
func _ready() -> void:
	health_bar.set_max_health(health)
	health_bar.update_health(health)

func _physics_process(_delta: float) -> void:
	_handle_movement()
	_velocity = move_and_slide(_velocity)


func _handle_movement():
	var direction = _get_direction()
	_velocity = _get_velocity(direction)
	
	if _velocity.x < 0:
		change_direction(DIRECTION.LEFT)
	if _velocity.x > 0:
		change_direction(DIRECTION.RIGHT) 
	
	
func _get_velocity(direction):
	return Vector2(
		speed * direction.x,
		speed * direction.y
	)
	
	
func _get_direction():
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")	
	)
	
