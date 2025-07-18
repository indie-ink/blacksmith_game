class_name RythmBar

extends Area2D

const RYTHM_LETTER = preload("res://Scenes/RythmBar/RythmLetter/RythmLetter.tscn")
const ACTION_BY_LETTER: Dictionary[RythmLetter.LetterVariants, String] = {
	RythmLetter.LetterVariants.UP: "up",
	RythmLetter.LetterVariants.LEFT: "left",
	RythmLetter.LetterVariants.DOWN: "down",
	RythmLetter.LetterVariants.RIGHT: "right",
}

@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_marker: Marker2D = $SpawnMarker
@onready var hit_sound: AudioStreamPlayer2D = $HitSound

var _eneterd_letter: RythmLetter

func _unhandled_input(_event: InputEvent) -> void:
	if !_eneterd_letter: return

	var variant: RythmLetter.LetterVariants = _eneterd_letter.get_variant()

	if Input.is_action_just_pressed(ACTION_BY_LETTER[variant]):
		_eneterd_letter.queue_free()
		hit_sound.play()
		SignalHub.emit_player_action_requested(Player.ActionTypes.HIT_ANVIL)


func _enter_tree() -> void:
	SignalHub.anvil_stage_started.connect(handle_anvil_stage_started)
	SignalHub.anvil_stage_passed.connect(handle_anvil_stage_passed)
	SignalHub.reset_stages_states.connect(handle_anvil_stage_passed)


func handle_anvil_stage_started() -> void:
	spawn_letter()
	spawn_timer.start()


func handle_anvil_stage_passed() -> void:
	spawn_timer.stop()
	for letter in get_tree().get_nodes_in_group(RythmLetter.GROUP_NAME):
		letter.call_deferred("queue_free")


func spawn_letter() -> void:
	var letter = RYTHM_LETTER.instantiate()

	spawn_marker.add_child(letter)
	letter.setup(RythmLetter.LetterVariants.values().pick_random())


func _on_spawn_timer_timeout() -> void:
	spawn_letter()


func _on_area_entered(area: Area2D) -> void:
	if area is RythmLetter:
		_eneterd_letter = area


func _on_area_exited(area: Area2D) -> void:
	if area is RythmLetter:
		_eneterd_letter = null


func _on_miss_bar_area_entered(area: Area2D) -> void:
	if area is RythmLetter:
		area.play_failed_animation()
		SignalHub.emit_anvil_hit_missed()
