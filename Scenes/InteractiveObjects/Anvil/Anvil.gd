class_name Anvil

extends InteractiveObject

const GROUP_NAME := "anvil"
const WAIT_AFTER_HIT_TIME := 0.7
const PARTICLE_LIFETIME := 1

@onready var pick_up_item: PickUpItem = $PickUpItem
@onready var sparks_particles: CPUParticles2D = $SparksParticles

@export var times_to_hit := 10

var _total_hits := 0
var _stage_entered := false



func _enter_tree() -> void:
	add_to_group(GROUP_NAME)
	SignalHub.player_action_performed.connect(handle_player_action_performed)


func handle_interaction() -> void:
	if GameManager.is_stage_allowed(GameManager.CraftingStage.ANVIL):
		if _stage_entered: return

		_stage_entered = true
		SignalHub.emit_anvil_stage_started()
		SignalHub.emit_player_disable_actions_requested()


func request_player_hammer_hit() -> void:
	SignalHub.emit_player_action_requested(Player.ActionTypes.HIT_ANVIL)


func handle_player_action_performed(action_type: Player.ActionTypes) -> void:
	if action_type != Player.ActionTypes.HIT_ANVIL: return

	spawn_hit_effect()

	_total_hits += 1

	if _total_hits == times_to_hit:
		await get_tree().create_timer(WAIT_AFTER_HIT_TIME).timeout

		_total_hits = 0
		_stage_entered = false
		SignalHub.emit_anvil_passed()
		pick_up_item.handle_picked_up()


func spawn_hit_effect() -> void:
	var new_particle: CPUParticles2D = sparks_particles.duplicate()

	add_child(new_particle)

	new_particle.position = Vector2(0, -6)
	new_particle.one_shot = true
	new_particle.emitting = true

	await get_tree().create_timer(PARTICLE_LIFETIME).timeout
	new_particle.call_deferred("queue_free")
