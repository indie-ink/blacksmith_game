class_name PickUpItem

extends Node2D

@export var sprite: Texture2D
@export var pickup_sound: Resource = preload("res://Assets/SFX/MAGAngl_BUFF-Buff Pickup_HY_PC-002.wav")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sound: AudioStreamPlayer2D = $Sound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = sprite
	sprite_2d.hide()
	sound.stream = pickup_sound


func handle_picked_up() -> void:
	animation_player.play("pick_up")


func play_sound() -> void:
	sound.play()
