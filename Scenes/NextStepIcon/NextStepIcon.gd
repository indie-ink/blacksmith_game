extends TextureRect

const ICON_BY_STAGE: Dictionary[GameManager.CraftingStage, Resource] = {
	GameManager.CraftingStage.IDLE: preload("res://Assets/Sprites/2 Objects/Rock.PNG"),
	GameManager.CraftingStage.ORE_ROCK: preload("res://Assets/Sprites/4 Icons/FurnaceIcon.png"),
	GameManager.CraftingStage.FURNACE: preload("res://Assets/Sprites/4 Icons/AnvilIcon.png"),
	GameManager.CraftingStage.ANVIL: preload("res://Assets/Sprites/4 Icons/WaterBarrelIcon.png"),
	GameManager.CraftingStage.WATER_BARREL: preload("res://Assets/Sprites/2 Objects/Rack.png")
}

@onready var icon_texture: TextureRect = $MarginContainer/IconTexture


func _ready() -> void:
	SignalHub.stage_updated.connect(handle_stage_updated)


func handle_stage_updated(stage: GameManager.CraftingStage) -> void:
	if !ICON_BY_STAGE[stage]: return
	
	icon_texture.texture = ICON_BY_STAGE[stage]
	flash_icon()


func flash_icon() -> void:
	var tween = create_tween()
	
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.1)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.1)
	
