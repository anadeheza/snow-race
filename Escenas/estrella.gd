extends Area2D

@export var vel: float = 800.0

func _ready() -> void:
	add_to_group("estrellas")

func _process(delta: float) -> void:
	position.x -= vel * delta
	
	if position.x < -600:
		queue_free()
