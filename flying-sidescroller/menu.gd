extends Control

@onready var level_1 = "res://levels/level_1.tscn"
@onready var level_2 = "res://levels/level_2.tscn"
@onready var level_3 = "res://levels/level_3.tscn"

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(level_3)

func _on_options_pressed() -> void:
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit()
