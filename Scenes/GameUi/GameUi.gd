extends Control

@onready var hint_label: Label = $HintLabel
@onready var hide_hint_button: TextureButton = $HideHintButton
@onready var score_label: Label = $ScoreLabel


func _ready() -> void:
	GameManager.initial_setup()
	SignalHub.balance_updated.connect(handle_balance_updated)


func handle_balance_updated(new_balance: int) -> void:
	score_label.text = "%06d" % new_balance


func _on_texture_button_pressed() -> void:
	hint_label.hide()
	hide_hint_button.hide()
