class_name Anvil

extends InteractiveObject

const WAIT_AFTER_HIT_TIME := 0.7

@onready var pick_up_item: PickUpItem = $PickUpItem

@export var times_to_hit := 3

var _total_hits := 0


func handle_interaction() -> void:
	if GameManager.is_stage_allowed(GameManager.CraftingStage.ANVIL):
		_total_hits += 1

		if _total_hits < times_to_hit:
			SignalHub.emit_hammer_hit()
		elif _total_hits == times_to_hit:
			SignalHub.emit_hammer_hit()

			await get_tree().create_timer(Player.HAMMER_HIT_TIME + WAIT_AFTER_HIT_TIME).timeout

			_total_hits = 0
			SignalHub.emit_anvil_passed()
			pick_up_item.handle_picked_up()
