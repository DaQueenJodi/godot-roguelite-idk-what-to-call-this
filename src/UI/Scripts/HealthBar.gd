extends Control

onready var health_bar = $Bar

func update_health(health: int) -> void:
	health_bar.value = health;

func set_max_health(health: int) -> void:
	health_bar.max_value = health
