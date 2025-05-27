class_name Sieve

extends InteractiveObject

@onready var pick_up_item: PickUpItem = $PickUpItem

func handle_action() -> void:
	if GameManager.is_stage_allowed(GameManager.CraftingStage.SIEVE):
		SignalHub.emit_ore_taken()
		pick_up_item.handle_picked_up()
