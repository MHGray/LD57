extends Node2D

@export var things_to_load:int
@export var things_loaded:int
var text = "Loaded things: \nThings Loaded: "
@onready var loading_message: RichTextLabel = $LoadingMessage
@onready var load_char: CharacterBody2D = $LoadChar

signal loading_complete

func _ready() -> void:
	test()
	load_char.velocity = Vector2.ONE * 4

func _process(delta: float) -> void:
	loading_message.text = text
	text = "Loaded things: %s\nThings to Load: %s" % [ things_loaded,things_to_load ]
	if things_loaded >= things_to_load:
		loading_complete.emit()
		queue_free()
		
	var collision: KinematicCollision2D = load_char.move_and_collide(load_char.velocity)
	if collision:
		var normal:Vector2 = collision.get_normal()
		if normal.x == 0:
			load_char.velocity = Vector2(load_char.velocity.x, -load_char.velocity.y)
		elif normal.y == 0:
			load_char.velocity = Vector2(-load_char.velocity.x, load_char.velocity.y)
			
	
	
	
func test():
	things_loaded += 1
	await get_tree().create_timer(1).timeout
	test()
