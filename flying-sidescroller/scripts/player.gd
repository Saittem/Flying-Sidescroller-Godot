extends CharacterBody2D

class_name Player

signal health_changed
signal player_died

@export var player_movement_speed: float = 500
@onready var player_animation_sprite = $PlayerAnimation
@onready var player_shield_animation = $ForceShieldAnimation
@onready var player_particle_animation = $ParticleAnimation
@onready var death_screen = $"../Camera2D/DeathScreen"
@onready var death_audio = $"DeathSoundEffect"
@onready var victory_audio = $"VictorySoundEffect"
@onready var hit_audio = $HitSoundEffect
@onready var power_up_audio = $PowerUpSoundEffect

const PLAYER_MAX_HEALTH : int = 100
var player_current_health : int = PLAYER_MAX_HEALTH
var invincibility_toggle : bool = false
var player_state : String

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

func get_input() -> void:
	var character_direction_y: float = Input.get_axis("move_up", "move_down")
	
	if character_direction_y != 0:
		velocity.y = character_direction_y * player_movement_speed
	else:
		velocity.y = velocity.move_toward(Vector2.ZERO, player_movement_speed).y

func activate_shield() -> void:
	power_up_audio.play()
	player_shield_animation.visible = true

func deactivate_shield() -> void:
	player_particle_animation.visible = true
	player_particle_animation.play("default")

func _on_particle_animation_animation_finished() -> void:
	player_particle_animation.visible = false
	player_shield_animation.visible = false

func update_animation() -> void:
	if velocity.y > 0:
		if player_state != "down":
			player_animation_sprite.play("down")
			player_state = "down"
	elif velocity.y < 0:
		if player_state != "up":
			player_animation_sprite.play("up")
			player_state = "up"
	else:
		player_animation_sprite.play("idle")
		player_state = "idle"

func toggle_invincibility() -> void:
	if invincibility_toggle:
		invincibility_toggle = false
	else:
		invincibility_toggle = true
		for i in range(4):
			player_animation_sprite.visible = !player_animation_sprite.visible
			await get_tree().create_timer(0.2).timeout
			player_animation_sprite.visible = !player_animation_sprite.visible
			await get_tree().create_timer(0.4).timeout
			#print("cycle " + str(i))
		toggle_invincibility()

func change_health(health_difference: int) -> void:
	if !invincibility_toggle:
		if !player_shield_animation.visible or health_difference > 0:
			player_current_health += health_difference
			if player_current_health > 100:
				player_current_health = 100
			else:
				health_changed.emit()
				if health_difference < 0:
					toggle_invincibility()
					hit_audio.play()
				if player_current_health <= 0:
					get_tree().paused = true
					death_audio.play()
					await get_tree().create_timer(0.5).timeout
					death_screen.visible = true
					player_died.emit()
		else:
			deactivate_shield()
			toggle_invincibility()
