class_name Weapon
extends Area2D

signal attack_finished


var what_to_play: String 
var what_is_playing: String 

onready var animation_player: = $AnimationPlayer
# enable _physics_process while attacking, disable when not


var curr_state: int = 0

func _ready() -> void:
	set_physics_process(false)
	
func attack() -> void:
	pass
	
	
func _change_state(new_state: int) -> void:
	if curr_state == new_state:
		return
	curr_state = new_state
	
func preform_state(state: int) -> void: # override
	pass

	

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
	
	
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	on_attack_done()

func get_what_to_play() -> String:
	return ""
func start_attack() -> void:
	pass
func on_attack() -> void : # override 
	pass
func on_hit(body: PhysicsBody2D) -> void: # override
	pass
func on_attack_done():
	pass
