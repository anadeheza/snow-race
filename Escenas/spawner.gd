extends Node2D

@export var obstaculo: PackedScene
@export var obstaculo2: PackedScene
@export var estrella: PackedScene 
@export var prob_est: float = 0.2
@export var spawn_x: float = 1400.0

func _on_timer_spawn_timeout() -> void:
	var carril: int = randi() % Carriles.CANT_CARRILES
	var y: float = Carriles.get_lane_y(carril)
	
	var inst: Area2D
	if randf() < prob_est:
		inst = estrella.instantiate()
	elif randf() < 0.5:
		inst = obstaculo.instantiate()
	else:
		inst = obstaculo2.instantiate()
		
	add_child(inst)
	inst.position = Vector2(spawn_x, y)
