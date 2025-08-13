extends Node

@onready var player := $"Player"
@onready var object_spawn_timer := $"ObjectSpawnTimer"
var health_up_object = preload("res://objects/health_up.tscn")
var power_up_object = preload("res://objects/power_up.tscn")
var bird_obstacle = preload("res://objects/bird_obstacle.tscn")
var tree_obstacle = preload("res://objects/tree_obstacle.tscn")
var screen_size : Vector2i

var obstacle_types := [bird_obstacle, tree_obstacle]
var power_up_types := [health_up_object, power_up_object]
var objects : Array


func _ready() -> void:
	screen_size = get_window().size
	object_spawn_timer.start()

func _process(_delta) -> void:
	$"Camera2D".position.x += player.speed
	$"HUD".position.x += player.speed

func _on_object_spawn_timer_timeout() -> void:
	var rounded_time_str = str(snapped(object_spawn_timer.wait_time, 0.01))
	print("Timer ended: " + rounded_time_str + "s")
	generate_object()
	object_spawn_timer.wait_time = randf_range(1.0, 3.0)

func generate_object():
	var object_type
	if (randi() % 20) >= 19:
		object_type = obstacle_types[randi() % obstacle_types.size()]
	else:
		object_type = power_up_types[randi() % power_up_types.size()]
	
	var object
	object = object_type.instantiate()
	var object_x = $"Camera2D".position.x + screen_size.x / 2 + 100
	var object_y = randi_range(100, screen_size.y)
	var object_str = str(object).left(-21)
	print(str("Spawned: " + object_str))
	add_object(object, object_x, object_y)

func add_object(object, x, y):
	object.position = Vector2i(x, y)
	add_child(object)
	objects.append(object)
