class_name Ore

extends RigidBody2D

const LAUNCH_SPEED_X_RSNGE := 60.0
const LAUNCH_SPEED_Y := -200.0

@onready var sprite_2d: Sprite2D = $Sprite2D


func launch() -> void:
	apply_central_impulse(
		Vector2(
			randf_range(-LAUNCH_SPEED_X_RSNGE, LAUNCH_SPEED_X_RSNGE),
			LAUNCH_SPEED_Y
		)
	)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		SignalHub.emit_ore_taken()
		call_deferred("queue_free")
