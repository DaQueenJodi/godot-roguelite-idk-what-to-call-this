class_name Weapon
extends Area2D

signal attack_finished

onready var animation_player: = $AnimationPlayer

# enable _physics_process while attacking, disable when not


enum STATES {
	IDLE,
	ATTACK
}

var curr_state: int = STATES.IDLE

func _ready() -> void:
	set_physics_process(false)
	
func attack() -> void:
	_change_state(STATES.ATTACK)
	
	
func _change_state(new_state: int) -> void:
	if curr_state == new_state:
		return
	curr_state = new_state

	match curr_state:
		STATES.IDLE:
			set_physics_process(false)
		STATES.ATTACK:
			set_physics_process(true) 
			animation_player.play("attack")

func _physics_process(delta: float) -> void:
	on_attack()
	
	if not is_monitoring():
		return
	var overlapping_bodies: = get_overlapping_bodies()
	if not overlapping_bodies:
		return
		
	for body in overlapping_bodies:
		on_hit(body)
	set_physics_process(false)
	
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		_change_state(STATES.ATTACK)


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "attack":
		_change_state(STATES.IDLE)
		emit_signal("attack_finished")


func on_attack() -> void : # override 
	pass
func on_hit(body: PhysicsBody2D) -> void: # override
	pass
