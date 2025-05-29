class_name Furnace

extends InteractiveObject

@onready var sound: AudioStreamPlayer2D = $Sound
@onready var pick_up_item: PickUpItem = $PickUpItem
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var forge_default: Sprite2D = $ForgeDefault

var _is_activated := false

func handle_interaction() -> void:
	if GameManager.is_stage_allowed(GameManager.CraftingStage.FURNACE):
		process_ore()

func process_ore() -> void:
	if _is_activated: return
	
	_is_activated = true
	
	forge_default.hide()
	sound.play()
	await get_tree().create_timer(0.8).timeout
	sound.play()
	await get_tree().create_timer(0.8).timeout
	sound.play()
	await get_tree().create_timer(0.8).timeout
	forge_default.show()

	pick_up_item.handle_picked_up()
	
	SignalHub.emit_ore_heated()
	
	_is_activated = false

	
