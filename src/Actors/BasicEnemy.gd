extends KinematicBody2D

onready var PlayerDetector = $PlayerDetector

var velocity = Vector2.ZERO
var speed = 200.0
var path = []
var threshold = 16
var nav = null
var player = null

func _physics_process(delta: float) -> void:
	if path.size() > 0:
		move_to_target()


func move_to_target():
	if global_position.distance_to(path[0]) < threshold:
		 path.remove(0)
	else:
		var direction = global_position.direction_to(path[0])
		velocity = direction * speed
		velocity = move_and_slide(velocity)

func get_target_path(target_pos):
	path = nav.get_simple_path(global_position, target_pos, false)


func _on_Timer_timeout() -> void:
	if player != null:
		get_target_path(player.global_position)
