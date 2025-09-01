extends Node

@onready var player := $"Player"
@onready var object_spawn_timer := $"ObjectSpawnTimer"
@onready var boundary := $"Boundary"
@onready var camera := $"Camera2D"
@onready var hud := $"Camera2D/HUD"
var health_up_object = preload("res://objects/health_up.tscn")
var power_up_object = preload("res://objects/power_up.tscn")

signal game_over

#level 1
var bird_obstacle = preload("res://objects/bird_obstacle.tscn")
var tree_obstacle = preload("res://objects/tree_obstacle.tscn")

#level 2

#level 3
var meteor_obstacle = preload("res://objects/meteor_obstacle.tscn")
var screen_size : Vector2i

var obstacle_types
var power_up_types := [health_up_object, power_up_object]
var objects : Array
@export var speed: int = 10
@export var max_distance = 100000
var current_distance

func _ready() -> void:
	get_tree().paused = false
	match self.name:
		"Level_1":
			obstacle_types = [bird_obstacle, tree_obstacle]
		"Level_2":
			pass
		"Level_3":
			obstacle_types = [meteor_obstacle]
	
	current_distance = camera.position.x
	hud.get_node("ProgressBar/TextureProgressBar").max_value = max_distance
	
	screen_size = get_window().size
	object_spawn_timer.start()

func _process(_delta) -> void:
	camera.position.x += speed
	boundary.position.x += speed
	player.position.x += speed
	current_distance += speed
	
	#for object in objects:
	#	if object.position.x < (camera.position.x - screen_size.x / 2 - 100):
	#		remove_object(object)
	
	hud.get_node("ProgressBar/TextureProgressBar").value = current_distance
	
	if current_distance >= max_distance:
		get_tree().paused = true
		camera.get_node("VictoryScreen").visible = true
		game_over.emit()

func _on_object_spawn_timer_timeout() -> void:
	var rounded_time_str = str(snapped(object_spawn_timer.wait_time, 0.01))
	#print("Timer ended: " + rounded_time_str + "s")
	generate_object()
	object_spawn_timer.wait_time = randf_range(1.0, 2.25)

func generate_object() -> void:
	var object_type
	if (randi() % 20) < 19:
		object_type = obstacle_types[randi() % obstacle_types.size()]
	else:
		object_type = power_up_types[randi() % power_up_types.size()]
	
	var object
	object = object_type.instantiate()
	var object_x = camera.position.x + screen_size.x / 2 + 100
	var object_y
	
	match object.name:
		"BirdObstacle":
			object_y = randi_range(50, screen_size.y - 250)
		"TreeObstacle":
			object_y = randi_range(600, screen_size.y + 25)
		_:
			object_y = randi_range(50, screen_size.y - 100)
	
	var object_str = str(object).left(-21)
	#print(str("Spawned: " + object_str))
	#print("Y: " + str(object_y))
	add_object(object, object_x, object_y)

func add_object(object, x, y) -> void:
	object.position = Vector2i(x, y)
	add_child(object)
	objects.append(object)

func remove_object(object) -> void:
	objects.erase(object)
	object.queue_free()
