extends Control

var menu_scene = "res://menu.tscn"

@onready var hover_audio = $HoverAudio
@onready var click_audio = $ClickAudio

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(menu_scene)
	click_audio.play()

func _on_button_mouse_entered() -> void:
	hover_audio.play()
