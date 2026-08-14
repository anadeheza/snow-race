extends Node2D

@export var meta_dist: float = 100000.0
@export var meta_scene: PackedScene
@export var dist_spawn: float = 1350.0  

@onready var fondo: Sprite2D = $Fondo
@onready var jugador: Area2D = $Jugador
@onready var ui: CanvasLayer = $UI
@onready var spawner: Node2D = $Spawner
@onready var timer_cuenta: Timer = $TimerCountdown
@onready var score: Label = $UI/Puntaje

var dist_act: float = 0.0
var tiempo: float = 0.0
var ganado: bool = false
var iniciado: bool = false
var cuenta_reg: int = 3
var meta_gen: bool = false

func _ready() -> void:
	jugador.puntaje_cambiado.connect(ui.actualizar_puntos)
	jugador.en_la_meta.connect(_on_meta_alcanzada)
	timer_cuenta.timeout.connect(_on_timer_cuenta_timeout)
	ui.jugar_pres.connect(_on_pressed)
	
	jugador.habilitado = false
	ui.mostrar_inicio()

func _on_pressed() -> void:
	ui.cuenta_reg(str(cuenta_reg))
	timer_cuenta.start()

func _on_timer_cuenta_timeout() -> void:
	cuenta_reg -= 1

	if cuenta_reg > 0:
		ui.cuenta_reg(str(cuenta_reg))
	elif cuenta_reg == 0:
		ui.cuenta_reg("¡YA!")
	else:
		timer_cuenta.stop()
		ui.ocultar_cuenta_reg()
		_iniciar_carrera()

func _iniciar_carrera() -> void:
	iniciado = true
	jugador.habilitado = true
	score.text = "Score: 0"
	spawner.get_node("TimerSpawn").start()
	fondo.habilitado = true


func _process(delta: float) -> void:
	if not iniciado or ganado:
		return

	tiempo += delta
	dist_act += jugador.vel_act * delta
	ui.actualizar_distancia(dist_act, meta_dist)
	ui.actualizar_tiempo(tiempo)

	if not meta_gen and dist_act >= meta_dist - dist_spawn:
		_generar_meta()

func _generar_meta() -> void:
	meta_gen = true
	spawner.get_node("TimerSpawn").stop()  
	var instancia: Area2D = meta_scene.instantiate()
	add_child(instancia)
	instancia.position = Vector2(1400, 0)

func _on_meta_alcanzada(puntaje_final: int) -> void:
	ganado = true
	ui.mostrar_victoria(puntaje_final, tiempo)
	get_tree().paused = true
