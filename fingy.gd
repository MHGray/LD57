extends Node3D

var max_height:float = 0
var min_height:float = -20
var amount_moved:float = 0
var dir:float = 1
var total_time:float

func _process(delta: float) -> void:
	total_time += delta
	var distance = sin(total_time) * .005
	global_transform.origin -= global_transform.basis.y * distance

	
