extends Control

@onready var ore_label: Label = $VBoxContainer/OreHB/OreLabel

func _enter_tree() -> void:
	SignalHub.ore_stage_state_updated.connect(handle_ore_stage_state_updated)


func handle_ore_stage_state_updated(current_ore: int, required_ore: int) -> void:
	ore_label.text = "Ore: %d / %d" % [current_ore, required_ore]
