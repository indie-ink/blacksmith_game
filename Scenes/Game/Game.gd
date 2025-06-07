extends Node2D


const MAIN_THEME_MUSIC_1 = preload("res://Assets/Music/Loopable + one shots/wav/07 - Port Town.wav")
const SMITHING_MUSIC_1 = preload("res://Assets/Music/Loopable + one shots/wav/01 - Falling Apart (Prologue).wav")
const DEFAULT_VOLUME = -28.0
const LOUD_VOLUME = -12.0

@onready var bg_music: AudioStreamPlayer = $BGMusic

func _enter_tree() -> void:
	SignalHub.anvil_stage_started.connect(handle_anvil_stage_started)
	SignalHub.anvil_stage_passed.connect(handle_anvil_stage_passed)
	SignalHub.anvil_stage_failed.connect(handle_anvil_stage_passed)

func _ready() -> void:
	play_main_theme_music()


func handle_anvil_stage_started() -> void:
	play_smithing_theme_music()


func handle_anvil_stage_passed() -> void:
	play_main_theme_music()


func play_main_theme_music() -> void:
	bg_music.stream = MAIN_THEME_MUSIC_1
	bg_music.volume_db = DEFAULT_VOLUME
	bg_music.play()


func play_smithing_theme_music() -> void:
	bg_music.stream = SMITHING_MUSIC_1
	bg_music.volume_db = LOUD_VOLUME
	bg_music.play()
