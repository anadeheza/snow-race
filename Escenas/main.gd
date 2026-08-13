extends Node2D

@export var meta: float = 100000.0
@export var meta_scene: PackedScene
@export var dist_spawn: float = 1350.0

@onready var jugador: Area2D = $Jugador
@onready var ui: CanvasLayer = $UI
@onready var spawner: Node2D = $Spawner
@onready var timer: Timer = $TimerCountdown
@onready var fondo: Sprite2D = $Fondo

var dist_act: float = 0.0
var tiempo: float = 0.0
var ganado: bool = false
var iniciado: bool = false
var reg: int = 3
var meta_gen: bool =false

func _ready() -> void:
	jugador.puntaje_cambiado.connect(ui.actualizar_puntos)
	jugador.en_la_meta.connect(_on_meta_alc)
	timer.timeout.connect(_on_timer_cuenta_timeout)
	
	jugador.habilitado = false
	ui.cuenta_reg(str(reg))
	timer.start()
	
func _on_timer_cuenta_timeout() -> void:
	reg -= 1
	
	if reg > 0:
		ui.cuenta_reg(str(reg))
	elif reg == 0:
		ui.cuenta_reg("GO!")
	else:
		timer.stop()
		ui.ocultar_cuenta_reg()
		_iniciar_carrera()

func _iniciar_carrera() -> void:
	iniciado = true 
	jugador.habilitado = true
	fondo.habilitado = true 
	spawner.get_node("TimerSpawn").start()

func _process(delta: float) -> void:
	if not iniciado or ganado:
		return
	
	tiempo += delta
	dist_act += jugador.vel_act * delta
	ui.actualizar_distancia(dist_act, meta)
	ui.actualizar_tiempo(tiempo)
	
	if not meta_gen and dist_act >= meta - dist_spawn:
		_generar_meta()

func _generar_meta() -> void:
	meta_gen = true
	spawner.get_node("TimerSpawn").stop()
	
	var inst: Area2D = meta_scene.instantiate()
	add_child(inst)
	var medio: int = Carriles.CANT_CARRILES / 2
	inst.position = Vector2(1400, Carriles.get_lane_y(medio))
	
func _on_meta_alc(puntaje_final: int) -> void:
	ganado = true
	ui.mostrar_victoria(puntaje_final, tiempo)
	get_tree().paused = true
