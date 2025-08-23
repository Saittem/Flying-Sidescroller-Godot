extends Control

@onready var level_1 = "res://levels/level_1.tscn"
@onready var level_2 = "res://levels/level_2.tscn"
@onready var level_3 = "res://levels/level_3.tscn"

@onready var menu_layer = $"MainMenu"
@onready var level_layer = $"Levels"
@onready var option_layer = $"Options"

# Main Menu buttons
func _on_start_pressed() -> void:
	menu_layer.visible = false
	level_layer.visible = true

func _on_options_pressed() -> void:
	menu_layer.visible = false
	option_layer.visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()

# Level buttons
func _on_level_1_button_pressed() -> void:
	get_tree().change_scene_to_file(level_1)

func _on_level_2_button_pressed() -> void:
	get_tree().change_scene_to_file(level_2)

func _on_level_3_button_pressed() -> void:
	get_tree().change_scene_to_file(level_3)
