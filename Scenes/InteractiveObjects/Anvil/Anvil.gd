class_name Anvil

extends InteractiveObject

@onready var pick_up_item: PickUpItem = $PickUpItem

@export var times_to_hit := 3

var _total_hits := 0


func handle_action() -> void:
	if GameManager.is_stage_allowed(GameManager.CraftingStage.ANVIL):
		if _total_hits < times_to_hit:
			SignalHub.emit_anvil_hit()
			_total_hits += 1
		else:
			_total_hits = 0
			SignalHub.emit_anvil_passed()
			pick_up_item.handle_picked_up()
