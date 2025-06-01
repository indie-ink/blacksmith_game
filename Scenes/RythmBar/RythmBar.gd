class_name RythmBar

extends Area2D

const RYTHM_LETTER = preload("res://Scenes/RythmBar/RythmLetter/RythmLetter.tscn")

@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_marker: Marker2D = $SpawnMarker


func _enter_tree() -> void:
	SignalHub.anvil_stage_started.connect(handle_anvil_stage_started)


func handle_anvil_stage_started() -> void:
	spawn_letter()
	spawn_timer.start()


func spawn_letter() -> void:
	var letter = RYTHM_LETTER.instantiate()
	
	spawn_marker.add_child(letter)
	letter.setup(RythmLetter.LetterVariants.values().pick_random())

func _on_spawn_timer_timeout() -> void:
	spawn_letter()
