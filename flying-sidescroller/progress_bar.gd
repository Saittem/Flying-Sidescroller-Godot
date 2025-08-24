extends Control

@onready var label = $"Label"
@onready var progress_bar = $"TextureProgressBar"

func _on_texture_progress_bar_value_changed(value: float) -> void:
	var edited_value : int = value / 1000 
	label.text = str(edited_value) + "%"
