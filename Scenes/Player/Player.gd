class_name Player

extends CharacterBody2D

enum ActionTypes { MINING, HIT_ANVIL }

const GROUP_NAME = "player"

const GRAVITY := 600
const RUN_SPEED := 80.0
const HAMMER_HIT_TIME := 0.9
const DEFAULT_ZOOM := 1.3
const ANVIL_ZOOM := 2.2
const ANVIL_OFFSET_X = 5.0
const ZOOM_SPEED = 3.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var camera_2d: Camera2D = $Camera2D

var _is_hitting_with_hammer := false
var _are_actions_enabled := true
var smooth_zoom = DEFAULT_ZOOM
var target_zoom = DEFAULT_ZOOM

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)
	SignalHub.player_action_requested.connect(handle_player_action_requested)
	SignalHub.anvil_stage_started.connect(handle_anvil_stage_started)
	SignalHub.anvil_passed.connect(handle_anvil_passed)


func _unhandled_input(event: InputEvent) -> void:
	process_movement_input()


func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta

	process_camera_zoom(delta)
	move_and_slide()


func process_camera_zoom(delta: float) -> void:
	if smooth_zoom == target_zoom: return

	smooth_zoom = lerp(smooth_zoom, target_zoom, ZOOM_SPEED * delta)
	camera_2d.zoom = Vector2(smooth_zoom, smooth_zoom)


func process_movement_input() -> void:
	if !_are_actions_enabled:
		velocity.x = 0
		return

	velocity.x = RUN_SPEED * Input.get_axis("left", "right")

	if not is_equal_approx(velocity.x, 0.0):
		sprite_2d.flip_h = velocity.x < 0


func handle_player_action_requested(action_type: ActionTypes) -> void:
	if action_type == ActionTypes.MINING and !_is_hitting_with_hammer:
		_is_hitting_with_hammer = true

		await get_tree().create_timer(HAMMER_HIT_TIME).timeout

		SignalHub.emit_player_action_performed(ActionTypes.MINING)
	elif action_type == ActionTypes.HIT_ANVIL:
		_is_hitting_with_hammer = true

		SignalHub.emit_player_action_performed(ActionTypes.HIT_ANVIL)


func play_anvil_hit_sound() -> void:
	sound.play()


func handle_anvil_stage_started() -> void:
	_are_actions_enabled = false
	target_zoom = 2.0
	global_position.x = get_tree().get_first_node_in_group(Anvil.GROUP_NAME).global_position.x + ANVIL_OFFSET_X
	sprite_2d.flip_h = true


func handle_anvil_passed() -> void:
	_are_actions_enabled = true
	target_zoom = DEFAULT_ZOOM


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hammer":
		_is_hitting_with_hammer = false
