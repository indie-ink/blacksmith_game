class_name Ore

extends RigidBody2D

const LAUNCH_SPEED_X_RSNGE := 60.0
const LAUNCH_SPEED_Y := -200.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sound: AudioStreamPlayer2D = $Sound

var _is_collected := false


func launch() -> void:
	apply_central_impulse(
		Vector2(
			randf_range(-LAUNCH_SPEED_X_RSNGE, LAUNCH_SPEED_X_RSNGE),
			LAUNCH_SPEED_Y
		)
	)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !_is_collected and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_is_collected = true
		hide()
		sound.play()
		SignalHub.emit_ore_taken()



func _on_sound_finished() -> void:
	call_deferred("queue_free")
