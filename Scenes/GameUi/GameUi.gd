extends Control

@onready var score_label: Label = $ScoreLabel
@onready var hint_background: ColorRect = $HintBackground


func _ready() -> void:
	GameManager.initial_setup()
	SignalHub.balance_updated.connect(handle_balance_updated)


func handle_balance_updated(new_balance: int) -> void:
	score_label.text = "%06d" % new_balance


func _on_texture_button_pressed() -> void:
	hint_background.hide()
