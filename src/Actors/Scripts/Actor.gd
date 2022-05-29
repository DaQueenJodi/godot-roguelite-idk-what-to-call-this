extends KinematicBody2D
class_name Actor

export var health: = 1

const FLOOR_NORMAL: = Vector2.UP

export var speed: = 300

var _velocity: = Vector2.ZERO

# warning-ignore:unused_argument
func take_damage(dmg: int) -> void: # override
	pass
