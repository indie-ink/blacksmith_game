class_name WaterBarrel

extends InteractiveObject

@onready var pick_up_item: PickUpItem = $PickUpItem

func handle_action() -> void:
	if GameManager.is_stage_allowed(GameManager.CraftingStage.WATER_BARREL):
		SignalHub.emit_weapon_cooled()
		pick_up_item.handle_picked_up()
