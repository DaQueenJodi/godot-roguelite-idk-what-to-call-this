extends MeleeWeapon

export var damage: = 10

#onready var user: = owner

func on_hit(body: PhysicsBody2D) -> void:
	body.take_damage(damage)

func get_what_to_play() -> String: # return DIRECTION
	if owner.direction == owner.DIRECTION.LEFT:
		return "attack_left"
	if owner.direction == owner.DIRECTION.RIGHT:
		return "attack_right"
	else:
		push_error("moving neither right nor left")
		return ""
		
	
