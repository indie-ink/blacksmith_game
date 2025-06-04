class_name WeaponRack

extends InteractiveObject

const CREATED_WEAPON = preload("res://Scenes/InteractiveObjects/WeaponRack/CreatedWeapon/CreatedWeapon.tscn")
const WAIT_FOR_THROW_TIME := 1.4

@onready var pick_up_item: PickUpItem = $PickUpItem
@onready var weapon_landing_marker: Marker2D = $WeaponLandingMarker

func handle_interaction() -> void:
	if GameManager.is_stage_allowed(GameManager.CraftingStage.WEAPON_RACK):
		spawn_weapon()
		
		await get_tree().create_timer(WAIT_FOR_THROW_TIME).timeout
		
		SignalHub.emit_weapon_sold()
		pick_up_item.handle_picked_up()


func spawn_weapon() -> void:
	var weapon: CreatedWeapon = CREATED_WEAPON.instantiate()
	
	add_child(weapon)
	
	weapon.global_position = get_tree().get_first_node_in_group(Player.GROUP_NAME).global_position
	
	animation_created_weapon(weapon)


func animation_created_weapon(weapon: RigidBody2D) -> void:
	weapon.add_constant_torque(30)
	var mid = weapon_landing_marker.global_position - weapon.global_position
	
	mid.y -= 400
	
	weapon.apply_central_force(mid / 2)


func _on_weapon_landing_body_entered(body: Node2D) -> void:
	if body is CreatedWeapon:
		print(body)
		body.sleeping = true
		body.global_position = weapon_landing_marker.global_position
		body.rotation = 0
