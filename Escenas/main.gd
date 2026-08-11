extends Node2D

@export var meta: float = 10000.0

@onready var jugador: Area2D = $Jugador
@onready var ui: CanvasLayer = $UI

var dist_act: float = 0.0
var tiempo: float = 0.0
var ganado: bool = false

func _ready() -> void:
	jugador.puntaje_cambiado.connect(ui.actualizar_puntos)

func _process(delta: float) -> void:
	if ganado:
		return
	
	tiempo += delta
	dist_act += jugador.vel_act * delta
	ui.actualizar_distancia(dist_act, meta)
	ui.actualizar_tiempo(tiempo)
	
	if dist_act >= meta:
		ganado = true 
		ui.mostrar_victoria(jugador.puntaje, tiempo)
		get_tree().paused = true
