class_name OreRock

extends InteractiveObject

const ORE = preload("res://Scenes/InteractiveObjects/OrePile/Ore/Ore.tscn")
const PARTICLE_LIFETIME := 5

@export var particles: Array[CPUParticles2D] = []
@export var ore_needed_amount := 3
@export var hammer_hit_timeout := 2.0

@onready var pick_up_item: PickUpItem = $PickUpItem
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

var _current_ore_amount := 0

func _enter_tree() -> void:
	SignalHub.player_action_performed.connect(handle_player_action_performed)
	SignalHub.ore_collected.connect(handle_ore_collected)


func handle_interaction() -> void:
	if GameManager.is_stage_allowed(GameManager.CraftingStage.ORE_ROCK):
		request_player_hammer_hit()


func request_player_hammer_hit() -> void:
	SignalHub.emit_player_action_requested(Player.ActionTypes.MINING)


func handle_player_action_performed(action_type: Player.ActionTypes) -> void:
	if action_type != Player.ActionTypes.MINING: return

	generate_stone_particles()
	spawn_ore()

func handle_ore_collected() -> void:
	_current_ore_amount += 1

	if _current_ore_amount >= ore_needed_amount:
		_current_ore_amount = 0
		SignalHub.emit_ore_stage_passed()
		pick_up_item.handle_picked_up()


func spawn_ore() -> void:
	var ore: Ore = ORE.instantiate()

	add_child(ore)
	ore.launch()


func generate_stone_particles() -> void:
	for particle in particles:
		setup_particle(particle)


func setup_particle(particle: CPUParticles2D) -> void:
	var new_particle: CPUParticles2D = particle.duplicate()

	add_child(new_particle)
	new_particle.one_shot = true
	new_particle.emitting = true

	await get_tree().create_timer(PARTICLE_LIFETIME).timeout
	new_particle.call_deferred("queue_free")
