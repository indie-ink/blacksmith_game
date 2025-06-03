class_name RythmLetter

extends Area2D

enum LetterVariants { W, A, S, D }

const GROUP_NAME := "rythm_letter"
const DEFAULT_FALLING_SPEED := 40.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var _speed := DEFAULT_FALLING_SPEED
var _letter_variant: LetterVariants


func _enter_tree() -> void:
	add_to_group(GROUP_NAME)


func _process(delta: float) -> void:
	position.y += delta * _speed


func setup(letter_variant: LetterVariants, speed = DEFAULT_FALLING_SPEED) -> void:
	if !LetterVariants.values().has(letter_variant):
		queue_free()

	_speed = speed
	_letter_variant = letter_variant

	match letter_variant:
		LetterVariants.W:
			animated_sprite_2d.play("W")
		LetterVariants.A:
			animated_sprite_2d.play("A")
		LetterVariants.S:
			animated_sprite_2d.play("S")
		LetterVariants.D:
			animated_sprite_2d.play("D")


func get_variant() -> LetterVariants:
	return _letter_variant


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	call_deferred("queue_free")
