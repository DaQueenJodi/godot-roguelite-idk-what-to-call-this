extends Weapon

export var damage: = 10


func on_hit(body: PhysicsBody2D) -> void:
	body.take_damage(damage)