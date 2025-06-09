extends Control

@onready var sword_button: TextureButton = $HBoxContainer/SwordButton
@onready var axe_button: TextureButton = $HBoxContainer/AxeButton
@onready var spear_button: TextureButton = $HBoxContainer/SpearButton


func _on_sword_button_pressed() -> void:
	SignalHub.emit_select_item_to_craft(StagesStateManager.CraftingItemsType.SWORD)


func _on_axe_button_pressed() -> void:
	SignalHub.emit_select_item_to_craft(StagesStateManager.CraftingItemsType.AXE)


func _on_spear_button_pressed() -> void:
	SignalHub.emit_select_item_to_craft(StagesStateManager.CraftingItemsType.SPEAR)
