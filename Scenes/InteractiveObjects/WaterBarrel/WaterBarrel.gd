class_name WaterBarrel

extends InteractiveObject

const SHOW_STEAM_TIME := 2.0
const MAX_WEAPON_ROTATION := 20.0
const MAX_WEAPON_OFFSET := 3.5

@export var cooling_distance_to_pass := 10000

@onready var pick_up_item: PickUpItem = $PickUpItem
@onready var steam_animated_sprite_2d: AnimatedSprite2D = $SteamAnimatedSprite2D
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var sword_sprite: Sprite2D = $SwordSprite

var _is_used := false
var _cooling_distance := 0.0


func _unhandled_input(event: InputEvent) -> void:
	super(event)

	if _is_used and event is InputEventMouseMotion:
		var new_rotation: float = sword_sprite.rotation_degrees + event.screen_relative.x * 0.05
		var new_position_x: float = sword_sprite.position.x + event.screen_relative.x * 0.02

		sword_sprite.rotation_degrees = clamp(new_rotation, -MAX_WEAPON_ROTATION, MAX_WEAPON_ROTATION)
		sword_sprite.position.x = clamp(new_position_x, -MAX_WEAPON_OFFSET, MAX_WEAPON_OFFSET)

		_cooling_distance += abs(event.screen_relative.x)

		if _cooling_distance > cooling_distance_to_pass:
			reset_stage()
			SignalHub.emit_water_barrel_stage_passed()
			pick_up_item.handle_picked_up()


func handle_interaction() -> void:
	if GameManager.is_stage_allowed(GameManager.CraftingStage.WATER_BARREL):
		if _is_used: return

		_is_used = true

		sword_sprite.show()
		steam_animated_sprite_2d.show()
		sound.play()


func reset_stage() -> void:
	steam_animated_sprite_2d.hide()
	sword_sprite.hide()
	_is_used = false
	_cooling_distance = 0
