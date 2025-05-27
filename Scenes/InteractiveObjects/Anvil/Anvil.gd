class_name Anvil

extends InteractiveObject

@onready var pick_up_item: PickUpItem = $PickUpItem

func handle_action() -> void:
	if GameManager.is_stage_allowed(GameManager.CraftingStage.ANVIL):
		SignalHub.emit_hammer_smashed()
		pick_up_item.handle_picked_up()
