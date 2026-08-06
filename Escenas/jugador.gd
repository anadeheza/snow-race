extends Area2D

@export var carriles: int = 4
@export var pos_x: float = 50.0

var carril_act: int 
var target_y: float

func _ready() -> void:
	carril_act = carriles / 2
	position.x = pos_x
	_update_target_y()
	position.y = target_y

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		_cambiar_carril(-1)
	elif Input.is_action_just_pressed("ui_down"):
		_cambiar_carril(1)

func _cambiar_carril(direction: int) -> void:
	var nuevo_carril = carril_act + direction
	if nuevo_carril < 0:
		nuevo_carril = 0
	elif nuevo_carril > carriles - 1:
		nuevo_carril = carriles -1
		
	carril_act = nuevo_carril
	_update_target_y()
	position.y = target_y

func _update_target_y() -> void:
	var vh = get_viewport_rect().size.y
	var esp = (vh / carriles) - 40
	target_y = (esp * carril_act + esp / 2.0) + 110
