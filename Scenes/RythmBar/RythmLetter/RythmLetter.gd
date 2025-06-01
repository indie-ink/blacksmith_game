class_name RythmLetter

extends Area2D

enum LetterVariants { W, A, S, D }

const DEFAULT_FALLING_SPEED := 30.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var _speed := DEFAULT_FALLING_SPEED


func _process(delta: float) -> void:
	position.y += delta * _speed


func setup(letter_variant: LetterVariants, speed = DEFAULT_FALLING_SPEED) -> void:
	if !LetterVariants.values().has(letter_variant):
		queue_free()

	_speed = speed

	match letter_variant:
		LetterVariants.W:
			animated_sprite_2d.play("W")
		LetterVariants.A:
			animated_sprite_2d.play("A")
		LetterVariants.S:
			animated_sprite_2d.play("S")
		LetterVariants.D:
			animated_sprite_2d.play("D")


func _on_area_entered(area: Area2D) -> void:
	if area is RythmBar: 
		print("ENTERED")
		queue_free()
