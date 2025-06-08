extends Control

@onready var ore_label: Label = $VBoxContainer/OreHB/OreLabel
@onready var furnace_heat_label: Label = $VBoxContainer/FurnaceHeatHB/FurnaceHeatLabel
@onready var furnace_overheat_label: Label = $VBoxContainer/FurnaceOverheatHB/FurnaceOverheatLabel
@onready var anvil_reached_hits_label: Label = $VBoxContainer/AnvilReachedHitsHB/AnvilReachedHitsLabel
@onready var anvil_missed_hits_label: Label = $VBoxContainer/AnvilMissedHitsHB/AnvilMissedHitsLabel


func _enter_tree() -> void:
	SignalHub.ore_stage_state_updated.connect(handle_ore_stage_state_updated)
	SignalHub.furnace_stage_state_updated.connect(handle_furnace_stage_state_updated)
	SignalHub.anvil_stage_state_updated.connect(handle_anvil_stage_state_updated)


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


func handle_anvil_stage_state_updated(
	hits_reached: int,
	hits_missed: int,
	hits_required: int,
	max_hits_missed: int
) -> void:
	anvil_reached_hits_label.text = "Hits Reached: %d / %d" % [hits_reached, hits_required]
	anvil_missed_hits_label.text = "Hits Missed: %d / %d" % [hits_missed, max_hits_missed]
