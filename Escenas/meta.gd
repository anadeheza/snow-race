extends Area2D

@export var vel: float = 500.0

@onready var jugador: Area2D = get_node("../Jugador")

func _ready() -> void:
	add_to_group("meta")

func _process(delta: float) -> void:
	var vel_scroll: float = jugador.vel_act + vel
	position.x -= vel_scroll * delta
	if position.x <- 600:
		queue_free()
