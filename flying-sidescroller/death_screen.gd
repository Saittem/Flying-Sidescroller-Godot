extends Control

var menu_scene = "res://menu.tscn"

@onready var restart_button = $HBoxContainer/RestartButton
@onready var menu_button = $HBoxContainer/MenuButton

@onready var hover_audio = $HoverAudio
@onready var click_audio = $ClickAudio

func _ready() -> void:
	restart_button.mouse_entered.connect(_button_mouse_entered)
	menu_button.mouse_entered.connect(_button_mouse_entered)

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
	click_audio.play()

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(menu_scene)
	click_audio.play()

func _button_mouse_entered():
	hover_audio.play()
