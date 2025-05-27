class_name Player

extends CharacterBody2D

const GRAVITY := 600
const RUN_SPEED := 80.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _unhandled_input(event: InputEvent) -> void:	
	process_movement_input()


func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	move_and_slide()


func process_movement_input() -> void:
	velocity.x = RUN_SPEED * Input.get_axis("left", "right")
	
	if not is_equal_approx(velocity.x, 0.0):
		animated_sprite_2d.play("walk")
		animated_sprite_2d.flip_h = velocity.x < 0
	else:
		animated_sprite_2d.play("idle")
