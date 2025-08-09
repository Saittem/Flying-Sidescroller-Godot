extends CharacterBody2D

var player_health : int = 100
@export var player_movement_speed : int = 1000
const PLAYER_START_HORIZONTAL_SPEED : int = 10
const PLAYER_MAX_HORIZONTAL_SPEED : int = 25
var speed : float
var character_direction : Vector2

func _process(_delta) -> void:
	speed = PLAYER_START_HORIZONTAL_SPEED
	
	$".".position.x += speed
	$".".get_parent().get_node("Camera2D").position.x += speed

func _physics_process(_delta) -> void:
	character_direction.y = Input.get_axis("move_up", "move_down")
	
	if character_direction:
		velocity.y = character_direction.y * player_movement_speed
		if Input.is_action_pressed("move_up") and $AnimatedSprite2D.animation != "up":
			$AnimatedSprite2D.play("up")
		elif Input.is_action_pressed("move_down") and $AnimatedSprite2D.animation != "down":
			$AnimatedSprite2D.play("down")
		elif not Input.is_action_just_pressed("move_up") and $AnimatedSprite2D.animation == "up":
			$AnimatedSprite2D.play_backwards("up")
		elif not Input.is_action_just_pressed("move_down") and $AnimatedSprite2D.animation == "down":
			$AnimatedSprite2D.play_backwards("down")
	else:
		velocity.y = velocity.move_toward(Vector2.ZERO, player_movement_speed).y

	
	move_and_slide()
