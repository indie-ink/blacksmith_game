class_name PickUpItem

extends Node2D

@export var sprite: Texture2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = sprite
	sprite_2d.hide()


func handle_picked_up() -> void:
	animation_player.play("pick_up")
