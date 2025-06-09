extends Node

var _balance := 0
var _price_deviation := 0.15

func _enter_tree() -> void:
	SignalHub.weapon_sold.connect(handle_weapon_sold)


func initial_setup() -> void:
	_balance = 0
	SignalHub.emit_balance_updated(_balance)


func handle_weapon_sold() -> void:
	var _current_item_price = StagesStateManager.get_selected_item_to_craft_price()

	_balance += randf_range(
		_current_item_price - _current_item_price * _price_deviation,
		_current_item_price + _current_item_price * _price_deviation
	)
	SignalHub.emit_balance_updated(_balance)
