extends CanvasLayer

@onready var inicio: Control = $Menu
@onready var jugar: Button = $Menu/Inicio/Jugar
signal jugar_pres

@onready var cuenta: Control = $Countdown
@onready var labelCuenta: Label = $Countdown/Label

@onready var puntos: Label = $Puntaje
@onready var dist: Label = $Distancia
@onready var tiempo: Label = $Tiempo

@onready var victoria: Control = $Win
@onready var tiempo_fin: Label = $Win/Victoria/HBoxContainer/tiempo
@onready var puntaje_fin: Label = $Win/Victoria/HBoxContainer2/puntaje
@onready var salir: Button = $Win/Victoria/Salir

func _ready() -> void:
	victoria.visible = false
	jugar.pressed.connect(_on_pressed)
	salir.pressed.connect(_on_salir_pressed)

func _on_salir_pressed() -> void: 
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_pressed() -> void:
	inicio.visible = false
	jugar_pres.emit()

func mostrar_inicio() -> void:
	inicio.visible = true

func cuenta_reg(text: String) -> void:
	cuenta.visible = true
	labelCuenta.text = text

func ocultar_cuenta_reg() -> void:
	cuenta.visible = false

func actualizar_puntos(nuevo_puntaje: int) -> void:
	puntos.text = "Score: " + str(nuevo_puntaje)

func actualizar_distancia(actual: float, meta: float) -> void:
	dist.text = "%dm / %dm " % [actual, meta]

func actualizar_tiempo(segundos: float) -> void:
	var secs: int = int(segundos) % 60
	var ms: int = int((segundos - int(segundos)) * 1000)
	tiempo.text = "%02d:%02ds" % [secs, ms]

func mostrar_victoria(puntaje_final: int, tiempo_hecho: float) -> void:
	var secs: int = int(tiempo_hecho) % 60
	var ms: int = int((tiempo_hecho - int(tiempo_hecho)) * 1000)

	tiempo_fin.text = "%02d:%02ds" % [secs, ms]
	puntaje_fin.text = str(puntaje_final)

	victoria.visible = true
	puntos.visible = false
	tiempo.visible = false
	dist.visible = false
