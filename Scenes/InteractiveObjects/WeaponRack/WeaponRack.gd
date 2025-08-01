class_name WeaponRack

extends InteractiveObject

const CREATED_WEAPON = preload("res://Scenes/InteractiveObjects/WeaponRack/CreatedWeapon/CreatedWeapon.tscn")
const WAIT_FOR_THROW_TIME := 1.3
const WAIT_BEFORE_SELL_TIME := 1.8
const SEND_TO_SELL_POINT_TIME := 1
const LAUNCH_IN_THE_AIR_FORCE := 400.0

@export var sell_weapon_point: Marker2D = null

@onready var pick_up_item: PickUpItem = $PickUpItem
@onready var weapon_landing_marker: Marker2D = $WeaponLandingMarker
@onready var throw_sound: AudioStreamPlayer2D = $ThrowSound

var _current_weapon: CreatedWeapon = null

func handle_interaction() -> void:
	if GameManager.is_stage_allowed(GameManager.CraftingStage.WEAPON_RACK):
		if _current_weapon: return

		spawn_weapon()
		await get_tree().create_timer(WAIT_FOR_THROW_TIME).timeout
		SignalHub.emit_weapon_sold()
		SignalHub.emit_weapon_rack_stage_passed()
		SignalHub.emit_reset_stages_states()
		pick_up_item.handle_picked_up()
		await get_tree().create_timer(WAIT_BEFORE_SELL_TIME).timeout
		send_weapon_to_marker()


func spawn_weapon() -> void:
	_current_weapon = CREATED_WEAPON.instantiate()
	add_child(_current_weapon)
	_current_weapon.global_position = get_tree().get_first_node_in_group(Player.GROUP_NAME).global_position
	animation_created_weapon(_current_weapon)


func animation_created_weapon(weapon: RigidBody2D) -> void:
	weapon.add_constant_torque(50)
	var middle: Vector2 = weapon_landing_marker.global_position - weapon.global_position

	middle.y -= LAUNCH_IN_THE_AIR_FORCE
	weapon.apply_central_force(middle / 2)
	throw_sound.play()


func send_weapon_to_marker() -> void:
	if !sell_weapon_point:
		_current_weapon.call_deferred("queue_free")
	else:
		var tween: Tween = get_tree().create_tween()

		tween.set_ease(Tween.EASE_OUT)

		tween.parallel().tween_property(_current_weapon, "global_position", sell_weapon_point.global_position, SEND_TO_SELL_POINT_TIME)
		tween.parallel().tween_property(_current_weapon, "rotation_degrees", 1080, SEND_TO_SELL_POINT_TIME)
		tween.parallel().tween_property(_current_weapon, "scale", Vector2(0, 0), SEND_TO_SELL_POINT_TIME)

		tween.tween_callback(_current_weapon.queue_free)


func _on_weapon_landing_body_entered(body: Node2D) -> void:
	if body is CreatedWeapon:
		body.sleeping = true
		body.global_position = weapon_landing_marker.global_position
		body.rotation = 0
