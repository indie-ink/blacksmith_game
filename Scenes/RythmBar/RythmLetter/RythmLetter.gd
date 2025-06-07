class_name RythmLetter

extends Area2D

enum LetterVariants { W, A, S, D }

const GROUP_NAME := "rythm_letter"
const ANIMATION_BY_VARIANT: Dictionary[LetterVariants, String] = {
	LetterVariants.W: "W",
	LetterVariants.A: "A",
	LetterVariants.S: "S",
	LetterVariants.D: "D",
}

@export var falling_speed := 80.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var fail_sound: AudioStreamPlayer2D = $FailSound

var _speed := falling_speed
var _letter_variant: LetterVariants


func _enter_tree() -> void:
	add_to_group(GROUP_NAME)


func _process(delta: float) -> void:
	position.y += delta * _speed


func setup(letter_variant: LetterVariants, speed = falling_speed) -> void:
	if !LetterVariants.values().has(letter_variant):
		queue_free()

	_speed = speed
	_letter_variant = letter_variant

	animated_sprite_2d.play(ANIMATION_BY_VARIANT[letter_variant])


func get_variant() -> LetterVariants:
	return _letter_variant


func play_failed_animation() -> void:
	fail_sound.play()
	var tween: Tween = get_tree().create_tween()

	tween.tween_property(self, "position:x", position.x + 6, 0.03)
	tween.tween_property(self, "position:x", position.x - 6, 0.03)
	tween.tween_property(self, "position:x", position.x + 2, 0.03)
	tween.tween_property(self, "position:x", position.x - 2, 0.03)

	tween.tween_property(self, "modulate", Color(1, 0, 0, 1), 0.3)
	tween.tween_property(self, "modulate", Color(1, 0, 0, 0.01), 0.3)
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.3)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	call_deferred("queue_free")
