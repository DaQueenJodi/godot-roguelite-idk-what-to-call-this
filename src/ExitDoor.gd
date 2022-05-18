extends Area2D

signal leaving_level

func _on_body_entered(body: KinematicBody2D) -> void:
	emit_signal("leaving_level")	
