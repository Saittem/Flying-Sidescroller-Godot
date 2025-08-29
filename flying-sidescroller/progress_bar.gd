extends Control

@onready var label = $"Label"
@onready var progress_bar = $"TextureProgressBar"
@onready var player = $"../../../Player"
@onready var level_node = $"../../../"

var edited_value : int

func _ready() -> void:
	level_node.game_over.connect(save_best_progress)

func _on_texture_progress_bar_value_changed(value: float) -> void:
	edited_value = value / 1000
	label.text = str(edited_value) + "%"

func save_best_progress():
	match level_node.name:
		"Level_1":
			if Global.best_progress_level_1 < edited_value:
				Global.best_progress_level_1 = edited_value
				print(Global.best_progress_level_1)
		"Level_2":
			if Global.best_progress_level_2 < edited_value:
				Global.best_progress_level_2 = edited_value
		"Level_3":
			if Global.best_progress_level_3 < edited_value:
				Global.best_progress_level_3 = edited_value
