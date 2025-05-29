class_name OreRock

extends InteractiveObject

const ORE = preload("res://Scenes/InteractiveObjects/OrePile/Ore/Ore.tscn")
const PARTICLE_LIFETIME := 5

@export var particles: Array[CPUParticles2D] = []
@export var ore_needed_amount := 3
@export var hammer_hit_timeout := 2.0

@onready var pick_up_item: PickUpItem = $PickUpItem
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var hit_timeout_timer: Timer = $HitTimeoutTimer

var _current_ore_amount := 0
var _can_hit := true

func _enter_tree() -> void:
	SignalHub.ore_taken.connect(handle_ore_taken)


func handle_action() -> void:
	if _can_hit and GameManager.is_stage_allowed(GameManager.CraftingStage.ORE_ROCK):
		apply_hammer_hit()
		
		await get_tree().create_timer(Player.HAMMER_HIT_TIME).timeout
		
		generate_stone_particles()
		spawn_ore()


func apply_hammer_hit() -> void:
	_can_hit = false
	SignalHub.emit_hammer_hit()
	hit_timeout_timer.start(hammer_hit_timeout)

func handle_ore_taken() -> void:
	_current_ore_amount += 1
	
	if _current_ore_amount == ore_needed_amount:
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


func _on_hit_timeout_timer_timeout() -> void:
	_can_hit = true
