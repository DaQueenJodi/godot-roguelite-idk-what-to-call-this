extends Actor


onready var health_bar = $HealthBar

var path: = []
var threshold: = 16
var nav: Navigation2D = null
var player: KinematicBody2D = null

func take_damage(dmg: int) -> void:
	print("took damage")
	health -= dmg
	health_bar.update_health(health)
	

func _ready() -> void:
	health_bar.update_health(health)
	health_bar.set_max_health(health)


func _physics_process(delta: float) -> void:
	
	if health <= 0:
		queue_free()
		
	
	if path.size() > 0:
		move_to_target()


func move_to_target() -> void:
	if global_position.distance_to(path[0]) < threshold:
		 path.remove(0)
	else:
		var direction: = global_position.direction_to(path[0])
		_velocity = direction * speed
		_velocity = move_and_slide(_velocity)

func get_target_path(target_pos: Vector2):
	path = nav.get_simple_path(global_position, target_pos, false)


func _on_Timer_timeout() -> void:
	if player != null:
		get_target_path(player.global_position)
