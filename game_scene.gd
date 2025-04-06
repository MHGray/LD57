extends Node2D

@onready var slider: Node2D = $Throttle
@onready var indicator: Indicator = $Indicator

@onready var left_button: Btn = $LeftButton
@onready var right_button: Btn = $RightButton
@onready var compass: Compass = $Compass
var turn_speed:float = PI/8
@onready var wheel: Node2D = $Wheel
@onready var player: RigidBody3D = $SubViewportContainer/SubViewport/Reality/Player
