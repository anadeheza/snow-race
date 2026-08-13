extends CanvasLayer

@onready var puntos: Label = $Puntaje
@onready var dist: Label = $Distancia
@onready var tiempo: Label = $Tiempo
@onready var victoria: Control = $Win
@onready var labelVic: Label = $Win/Label
@onready var cuenta: Control = $Countdown
@onready var labelCuenta: Label = $Countdown/Label

func cuenta_reg(text: String) -> void:
	cuenta.visible = true 
	labelCuenta.text = text
	
func ocultar_cuenta_reg() -> void:
	cuenta.visible = false

func actualizar_puntos(nuevo_puntaje: int) -> void:
	puntos.text = "Score: " + str(nuevo_puntaje)
	
func actualizar_distancia(actual: float, meta: float) -> void:
	dist.text = "%dm / %dm " %[actual, meta] 

func actualizar_tiempo(segundos: float) -> void:
	var secs: int = int(segundos) % 60
	var ms: int = int((segundos - int(segundos)) * 1000 )
	tiempo.text = "%02d:%02ds" %[secs, ms]
	
func mostrar_victoria(puntaje_final: int, tiempo_hecho: float) -> void:
	victoria.visible = true
	var secs: int = int(tiempo_hecho) % 60
	var ms: int = int((tiempo_hecho - int(tiempo_hecho)) * 1000 )
	labelVic.text = "You Win!\nTime: %02d:%02ds\nScore: %d" %[secs, ms, puntaje_final]
