extends Control

@onready var ore_label: Label = $VBoxContainer/OreHB/OreLabel
@onready var furnace_heat_label: Label = $VBoxContainer/FurnaceHeatHB/FurnaceHeatLabel
@onready var furnace_overheat_label: Label = $VBoxContainer/FurnaceOverheatHB/FurnaceOverheatLabel

func _enter_tree() -> void:
	SignalHub.ore_stage_state_updated.connect(handle_ore_stage_state_updated)
	SignalHub.furnace_stage_state_updated.connect(handle_furnace_stage_state_updated)


func handle_ore_stage_state_updated(current_ore: int, required_ore: int) -> void:
	ore_label.text = "Ore: %d / %d" % [current_ore, required_ore]


func handle_furnace_stage_state_updated(
	current_heat_time: float,
	current_overheat_time: float,
	heat_time_required: float,
	max_overheat_time: float
) -> void:
	pass
	furnace_heat_label.text = "Heat: %.1f / %.1f" % [current_heat_time, heat_time_required]
	furnace_overheat_label.text = "Overheat: %.1f / %.1f" % [current_overheat_time, max_overheat_time]
