class_name WaterBarrel

extends InteractiveObject

@onready var pick_up_item: PickUpItem = $PickUpItem
@onready var steam_animated_sprite_2d: AnimatedSprite2D = $SteamAnimatedSprite2D
@onready var sound: AudioStreamPlayer2D = $Sound

func handle_interaction() -> void:
	if GameManager.is_stage_allowed(GameManager.CraftingStage.WATER_BARREL):
		steam_animated_sprite_2d.show()
		sound.play()
		await get_tree().create_timer(1).timeout
		steam_animated_sprite_2d.hide()
		
		SignalHub.emit_weapon_cooled()
		pick_up_item.handle_picked_up()
