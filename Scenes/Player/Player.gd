class_name Player

extends CharacterBody2D

const GRAVITY := 600
const RUN_SPEED := 80.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sound: AudioStreamPlayer2D = $Sound


var _is_smithing := false


func _enter_tree() -> void:
	SignalHub.anvil_hit.connect(handle_anvil_hit)


func _unhandled_input(event: InputEvent) -> void:
	process_movement_input()


func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	move_and_slide()


func process_movement_input() -> void:
	velocity.x = RUN_SPEED * Input.get_axis("left", "right")
	
	if not is_equal_approx(velocity.x, 0.0):
		sprite_2d.flip_h = velocity.x < 0


func handle_anvil_hit() -> void:
	_is_smithing = true


func play_anvil_hit_sound() -> void:
	sound.play()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hammer":
		_is_smithing = false
