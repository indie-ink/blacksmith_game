extends Node


@export var life_span: float = 30.0


func _ready() -> void:
	await get_tree().create_timer(life_span).timeout
	get_parent().queue_free()
