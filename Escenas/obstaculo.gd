extends Area2D

@export var vel: float = 300.0

func _process(delta: float) -> void:
	position.x -= vel * delta
	
	if position.x < -600:
		queue_free()
