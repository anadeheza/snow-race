extends Area2D

signal puntaje_cambiado(nuevo_punt: int)
signal en_la_meta(puntaje_final: int)

@export var pos_x: float = 50.0
@export var vel_ini: float = 600.0
@export var freno: float = 0.1
@export var freno2: float = 0.5
@export var aceleracion: float = 100.0
@export var desaceleracion: float = 1500.0

@onready var sprite: Sprite2D = $Jugador

var en_meta: bool = false 
var habilitado: bool = false
var carril_act: int 
var target_y: float
var puntaje: int = 0
var vel_act: float = 0.0

func frenazo() -> void:
	var tween := create_tween()
	tween.tween_property(sprite, "modulate", Color(1, 0.4, 0.4), 0.1)
	tween.parallel().tween_property(sprite, "scale", Vector2(0.1, 0.12), 0.1)
	tween.tween_property(sprite, "modulate", Color(1, 1, 1), 0.3)
	tween.parallel().tween_property(sprite, "scale", Vector2(0.14, 0.14), 0.3)

func frenazo2() -> void:
	var tween := create_tween()
	tween.tween_property(sprite, "position", Vector2(75, 20), 0.2)
	tween.tween_property(sprite, "rotation", -0.5, 0.4)
	tween.tween_property(sprite, "rotation", 0.5, 0.4)
	tween.tween_property(sprite, "position", Vector2(75, 100), 0.3)
	tween.tween_property(sprite, "rotation", 0.0, 0.3)
	tween.tween_property(sprite, "position", Vector2(75, 43), 0.5)

func _ready() -> void:
	carril_act = Carriles.CANT_CARRILES / 2
	position.x = pos_x
	target_y = Carriles.get_lane_y(carril_act)
	position.y = target_y
	vel_act = vel_ini
	area_entered.connect(_on_area_entered)
	
func _process(delta: float) -> void:
	if habilitado:
		if Input.is_action_just_pressed("ui_up"):
			_cambiar_carril(-1)
		elif Input.is_action_just_pressed("ui_down"):
			_cambiar_carril(1)
	
	if en_meta:
		vel_act -= desaceleracion * delta
		if vel_act <= 0:
			vel_act = 0
			en_meta = false
			en_la_meta.emit(puntaje)
	elif vel_act < vel_ini:
		vel_act += aceleracion * delta
		if vel_act > vel_ini:
			vel_act = vel_ini
	
	

func _cambiar_carril(direction: int) -> void:
	var nuevo_carril = carril_act + direction
	if nuevo_carril < 0:
		nuevo_carril = 0
	elif nuevo_carril > Carriles.CANT_CARRILES - 1:
		nuevo_carril = Carriles.CANT_CARRILES -1
		
	carril_act = nuevo_carril
	target_y = Carriles.get_lane_y(carril_act)
	position.y = target_y

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("estrellas"):
		puntaje += 1
		vel_act = vel_act + (aceleracion * 2)
		puntaje_cambiado.emit(puntaje)
		area.queue_free()
	elif area.is_in_group("obstaculos"):
		vel_act = vel_ini * freno
		frenazo()
		area.queue_free()
	elif area.is_in_group("obstaculos2"):
		vel_act = vel_ini * freno2
		frenazo2()
		area.queue_free()
	elif area.is_in_group("meta"):
		en_meta = true
		habilitado = false
