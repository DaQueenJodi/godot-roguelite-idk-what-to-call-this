extends Area2D

var player: KinematicBody2D = null

func _on_PlayerDetector_body_entered(body: KinematicBody2D) -> void:
	player = body # set player


func _on_PlayerDetector_body_exited(body: Node) -> void:
	player = null # unset player

func can_see_player() -> bool:
	return player != null 