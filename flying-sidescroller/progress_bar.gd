extends Control

@onready var label = $"Label"

func _on_texture_progress_bar_value_changed(value: float) -> void:
	label.text = str(value)
