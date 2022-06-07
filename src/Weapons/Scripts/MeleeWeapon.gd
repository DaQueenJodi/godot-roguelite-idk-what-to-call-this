class_name MeleeWeapon
extends Weapon

# enable _physics_process while attacking, disable when not


enum STATES {
	IDLE,
	ATTACK
}

func attack() -> void:
	_change_state(STATES.ATTACK)
	
func preform_state(state: int) -> void: 
	match state:
		STATES.IDLE:
			set_physics_process(false)
		STATES.ATTACK:
			what_to_play = get_what_to_play()
			animation_player.play(what_to_play)
			what_is_playing = what_to_play
			set_physics_process(true) 

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
	
	
func start_attack() -> void:
	_change_state(STATES.ATTACK)

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == what_is_playing:
		_change_state(STATES.IDLE)
		emit_signal("attack_finished")

func get_what_to_play() -> String:
	return ""

func on_attack() -> void : # override 
	pass
func on_hit(body: PhysicsBody2D) -> void: # override
	pass
