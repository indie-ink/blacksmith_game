class_name WaterBarrel

extends InteractiveObject

const SHOW_STEAM_TIME := 2.0

@onready var pick_up_item: PickUpItem = $PickUpItem
@onready var steam_animated_sprite_2d: AnimatedSprite2D = $SteamAnimatedSprite2D
@onready var sound: AudioStreamPlayer2D = $Sound

var _is_used := false

func handle_interaction() -> void:
	if GameManager.is_stage_allowed(GameManager.CraftingStage.WATER_BARREL):
		if _is_used: return
		
		_is_used = true
		
		steam_animated_sprite_2d.show()
		sound.play()
		
		await get_tree().create_timer(SHOW_STEAM_TIME).timeout
		
		steam_animated_sprite_2d.hide()
		
		SignalHub.emit_weapon_cooled()
		pick_up_item.handle_picked_up()
		
		_is_used = false
