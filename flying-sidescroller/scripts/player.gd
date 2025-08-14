extends CharacterBody2D

class_name Player

signal health_changed

@export var player_movement_speed: float = 500

const PLAYER_MAX_HEALTH : int = 100
var player_current_health : int = PLAYER_MAX_HEALTH

func _physics_process(delta) -> void:
	get_input()
	move_and_slide()
	update_animation()


func get_input():
	var character_direction_y: float = Input.get_axis("move_up", "move_down")
	
	if character_direction_y != 0:
		velocity.y = character_direction_y * player_movement_speed
	else:
		velocity.y = velocity.move_toward(Vector2.ZERO, player_movement_speed).y


func update_animation():
	if velocity.y > 0:
		$AnimatedSprite2D.play("down")
	elif velocity.y < 0:
		$AnimatedSprite2D.play("up")
	else:
		$AnimatedSprite2D.play("idle")

func take_damage(damage: int):
	player_current_health -= damage
	emit_signal("health_changed", player_current_health)
	if player_current_health <= 0:
		pass
