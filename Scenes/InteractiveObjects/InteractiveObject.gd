class_name InteractiveObject

extends Area2D

var is_player_in_range := false


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action") and is_player_in_range:
		handle_action()


func handle_action() -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		is_player_in_range = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		is_player_in_range = false
