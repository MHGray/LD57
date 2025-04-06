extends RigidBody3D

# How fast the player moves in meters per second.
@export var speed = 14
@export var left_button:Btn
@export var right_button:Btn
@export var wheel:Wheel
@export var throttle:Throttle
@export var toggle:Toggle
@export var compass:Compass
@export var bathymeter:Bathymeter
@onready var spotlight: SpotLight3D = $Spotlight

@export var dive_speed:float = 20
var target_depth:float = 0
var max_force_distance:float = 2
var throttle_amount:float = 0
var max_throttle_speed:float = 2

@export var indicator_down:Indicator
@onready var ray_cast_down: RayCast3D = $RayCastDown
@export var indicator_up:Indicator
@onready var ray_cast_up: RayCast3D = $RayCastUp
@export var indicator_left:Indicator
@onready var ray_cast_left: RayCast3D = $RayCastLeft
@export var indicator_right:Indicator
@onready var ray_cast_right: RayCast3D = $RayCastRight
@export var indicator_back:Indicator
@onready var ray_cast_back: RayCast3D = $RayCastBack


func _ready() -> void:
	wheel.turned.connect(move_vert)
	toggle.toggled.connect(func(value):spotlight.visible=value )
	
func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("right"):
		apply_impulse(Vector3(0,0,10*delta))
	if Input.is_action_pressed("left"):
		apply_impulse(Vector3(0,0,-10*delta))
	if Input.is_action_pressed("back"):
		apply_impulse(rotation * -speed * delta)
	if Input.is_action_pressed("forward"):
		apply_impulse(transform.basis.x * speed * delta)
	if throttle.percent > 0:
		apply_force(transform.basis.x *max_throttle_speed *throttle.percent )
	if position.y != -target_depth:
		var diff =  target_depth + position.y
		var force_to_apply = clampf(diff/max_force_distance,-1,1) * dive_speed
		if -target_depth > position.y:
			apply_force(Vector3.DOWN * force_to_apply)
		else:
			apply_force(Vector3.DOWN * force_to_apply)
	if left_button.selected:
		rotation.y += delta
		compass.heading = rotation.y
	if right_button.selected:
		rotation.y -= delta
		compass.heading = rotation.y
	bathymeter.depth = -position.y/5
	if ray_cast_down.is_colliding():
		indicator_down.value = Indicator.VALUE.RED
	else:
		indicator_down.value = Indicator.VALUE.GREEN
	if ray_cast_up.is_colliding():
		indicator_up.value = Indicator.VALUE.RED
	else:
		indicator_up.value = Indicator.VALUE.GREEN
	if ray_cast_left.is_colliding():
		indicator_left.value = Indicator.VALUE.RED
	else:
		indicator_left.value = Indicator.VALUE.GREEN
	if ray_cast_right.is_colliding():
		indicator_right.value = Indicator.VALUE.RED
	else:
		indicator_right.value = Indicator.VALUE.GREEN
	if ray_cast_back.is_colliding():
		indicator_back.value = Indicator.VALUE.RED
	else:
		indicator_back.value = Indicator.VALUE.GREEN
	
func move_vert(amount:float):
	target_depth += amount*2
	target_depth = max(0,target_depth)
