extends KinematicBody2D
class_name Actor

export var health: = 1

enum DIRECTION {LEFT, RIGHT, UP, DOWN}

var direction: int = DIRECTION.LEFT


const FLOOR_NORMAL: = Vector2.UP

export var speed: = 300

var _velocity: = Vector2.ZERO

# warning-ignore:unused_argument
func take_damage(dmg: int) -> void: # override
	pass

func change_direction(new_direction: int) -> void:
	direction = new_direction
