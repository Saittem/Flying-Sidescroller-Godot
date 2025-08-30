extends Control

@onready var level_1 = "res://levels/level_1.tscn"
@onready var level_2 = "res://levels/level_2.tscn"
@onready var level_3 = "res://levels/level_3.tscn"

@onready var menu_layer = $"MainMenu"
@onready var level_layer = $"Levels"
@onready var option_layer = $"Options"

#Audio
@onready var hover_audio = $HoverAudio
@onready var click_audio = $ClickAudio

#Buttons
@onready var start_button = $"MainMenu/VBoxContainer/Start"
@onready var options_button = $"MainMenu/VBoxContainer/Options"
@onready var quit_button = $"MainMenu/VBoxContainer/Quit"

@onready var level_1_button = $Levels/Level1/Level1Button
@onready var level_2_button = $Levels/Level2/Level2Button
@onready var level_3_button = $Levels/Level3/Level3Button

#Best progress labels
@onready var best_progress_level_1_label = $"Levels/Level1/BestProgress"
@onready var best_progress_level_2_label = $"Levels/Level2/BestProgress"
@onready var best_progress_level_3_label = $"Levels/Level3/BestProgress"


func _ready() -> void:
	get_tree().paused = false
	
	start_button.connect("pressed", Callable(self, "_button_pressed").bind(start_button))
	options_button.connect("pressed", Callable(self, "_button_pressed").bind(options_button))
	quit_button.connect("pressed", Callable(self, "_button_pressed").bind(quit_button))
	level_1_button.connect("pressed", Callable(self, "_button_pressed").bind(level_1_button))
	level_2_button.connect("pressed", Callable(self, "_button_pressed").bind(level_2_button))
	level_3_button.connect("pressed", Callable(self, "_button_pressed").bind(level_3_button))
	
	start_button.mouse_entered.connect(_button_mouse_entered)
	options_button.mouse_entered.connect(_button_mouse_entered)
	quit_button.mouse_entered.connect(_button_mouse_entered)
	level_1_button.mouse_entered.connect(_button_mouse_entered)
	level_2_button.mouse_entered.connect(_button_mouse_entered)
	level_3_button.mouse_entered.connect(_button_mouse_entered)
	
	best_progress_level_1_label.text = "Best: " + str(Global.best_progress_level_1) + "%"
	best_progress_level_2_label.text = "Best: " + str(Global.best_progress_level_2) + "%"
	best_progress_level_3_label.text = "Best: " + str(Global.best_progress_level_3) + "%"

#Buttons
func _button_pressed(button):
	click_audio.play()
	
	match button.name:
		"Start":
			menu_layer.visible = false
			level_layer.visible = true
		"Options":
			menu_layer.visible = false
			option_layer.visible = true
		"Quit":
			get_tree().quit()

func _button_mouse_entered():
	hover_audio.play()

# Level buttons
func _on_level_1_button_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(level_1)

func _on_level_2_button_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(level_2)

func _on_level_3_button_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(level_3)
