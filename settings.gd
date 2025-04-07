extends Node2D


func _on_back_btn_pressed() -> void:
	queue_free()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
