extends CharacterBody2D

class_name Player

signal health_changed

@export var player_movement_speed: float = 500
@onready var player_animation_sprite = $PlayerAnimation
@onready var player_shield_animation = $ForceShieldAnimation
@onready var player_particle_animation = $ParticleAnimation

const PLAYER_MAX_HEALTH : int = 100
var player_current_health : int = PLAYER_MAX_HEALTH

func _physics_process(delta) -> void:
	get_input()
	move_and_slide()
	update_animation()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("light_damage"):
		change_health(-25)
	elif area.is_in_group("heavy_damage"):
		change_health(-50)
	elif area.is_in_group("health_up"):
		change_health(25)
	elif area.is_in_group("power_up"):
		activate_shield()
		area.queue_free()

func get_input():
	var character_direction_y: float = Input.get_axis("move_up", "move_down")
	
	if character_direction_y != 0:
		velocity.y = character_direction_y * player_movement_speed
	else:
		velocity.y = velocity.move_toward(Vector2.ZERO, player_movement_speed).y

func activate_shield():
	player_shield_animation.visible = true

func deactivate_shield():
	player_particle_animation.visible = true
	player_particle_animation.play("default")

func _on_particle_animation_animation_finished() -> void:
	player_particle_animation.visible = false
	player_shield_animation.visible = false

func update_animation():
	if velocity.y > 0:
		player_animation_sprite.play("down")
	elif velocity.y < 0:
		player_animation_sprite.play("up")
	else:
		player_animation_sprite.play("idle")

func change_health(health_difference: int):
	if !player_shield_animation.visible or health_difference > 0:
		player_current_health += health_difference
		if player_current_health > 100:
			player_current_health = 100
		else:
			health_changed.emit()
			if player_current_health <= 0:
				pass
	else:
		deactivate_shield()
