extends Node

const LANE_COUNT: int = 4

func get_lane_y(lane_index: int) -> float:
	var viewport_height = get_viewport().get_visible_rect().size.y
	var lane_spacing = viewport_height / LANE_COUNT
	return lane_spacing * lane_index + lane_spacing / 2.0
