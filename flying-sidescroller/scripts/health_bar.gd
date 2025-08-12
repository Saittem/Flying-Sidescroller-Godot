extends ProgressBar

@onready var player := $"../../Player"

func _ready() -> void:
	player.health_changed.connect(updateHealthBar)
	updateHealthBar()

func updateHealthBar():
	value = player.player_current_health
