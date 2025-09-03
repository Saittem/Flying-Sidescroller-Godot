extends Node

var best_progress_level_1 : float
var best_progress_level_2 : float
var best_progress_level_3 : float

var sound_toggle : bool
var save_toggle : bool

var save_file_path = "user://flying_sidescroller_save_file.save"

signal save_game
#signal load_game

func _ready() -> void:
	load_data()
	save_game.connect(save_data)

func save_data():
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	file.store_var(best_progress_level_1)
	file.store_var(best_progress_level_2)
	file.store_var(best_progress_level_3)
	file.store_var(sound_toggle)
	file.store_var(save_toggle)

func load_data():
	if FileAccess.file_exists(save_file_path):
		var file = FileAccess.open(save_file_path, FileAccess.READ)
		best_progress_level_1 = file.get_var(best_progress_level_1)
		best_progress_level_2 = file.get_var(best_progress_level_2)
		best_progress_level_3 = file.get_var(best_progress_level_3)
		sound_toggle = file.get_var(sound_toggle)
		save_toggle = file.get_var(save_toggle)
	else:
		best_progress_level_1 = 0.0
		best_progress_level_2 = 0.0
		best_progress_level_3 = 0.0
		sound_toggle = true
		save_toggle = true
