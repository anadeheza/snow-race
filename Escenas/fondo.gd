extends Sprite2D

@export var vel: float = 1.0

@onready var jugador: Area2D = get_node("../Jugador")

var ancho: float
var otra: Sprite2D
var pos_ini: float

func _ready() -> void:
	z_index = -1
	
	pos_ini = position.x
	ancho = texture.get_size().x * scale.x 
	
	otra = duplicate()
	otra.set_script(null)
	otra.flip_h = not flip_h
	otra.z_index = -1
	
	get_parent().call_deferred("add_child", otra)
	otra.position = position + Vector2(ancho, 0)

func _process(delta: float) -> void:
	if not jugador:
		return
	
	var vel_scroll: float = jugador.vel_act * vel
	position.x -= vel_scroll * delta
	otra.position.x -= vel_scroll * delta
	
	_wrap(self, otra)
	_wrap(otra, self)

func _wrap(sprite_act: Sprite2D, sprite_ref: Sprite2D) -> void:
	if sprite_act.position.x <= pos_ini - ancho:
		sprite_act.position.x = sprite_ref.position.x + ancho
		sprite_act.flip_h = not sprite_ref.flip_h
