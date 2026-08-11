extends Node

const CANT_CARRILES: int = 4 

func get_lane_y(i: int) -> float:
	var vh = get_viewport().get_visible_rect().size.y
	var spacing = (vh / CANT_CARRILES) - 10
	return spacing * i + spacing / 2.0 + 10
