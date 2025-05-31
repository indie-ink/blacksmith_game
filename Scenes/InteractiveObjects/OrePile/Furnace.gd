class_name Furnace

extends InteractiveObject

@export var heat_power := 16.0
@export var heat_decrease_power := 3.0
@export var min_heat := 60.0
@export var max_heat := 79.0
@export var time_to_overheat := 2.0
@export var time_to_succeed := 4.0

@onready var heat_sound: AudioStreamPlayer2D = $HeatSound
@onready var fail_sound: AudioStreamPlayer2D = $FailSound

@onready var pick_up_item: PickUpItem = $PickUpItem
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var forge_without_fire: Sprite2D = $ForgeWithoutFire
@onready var thermometer_progress: TextureProgressBar = $Thermometer/ThermometerProgress
@onready var thermometer: Sprite2D = $Thermometer

@onready var heat_timeout_timer: Timer = $HeatTimeoutTimer
@onready var heat_decrease_timer: Timer = $HeatDecreaseTimer
@onready var overheat_timer: Timer = $OverheatTimer
@onready var success_timer: Timer = $SuccessTimer

var _can_heat := true

func _enter_tree() -> void:
	SignalHub.stage_updated.connect(handle_stage_updated)

func handle_interaction() -> void:
	if GameManager.is_stage_allowed(GameManager.CraftingStage.FURNACE):
		heat_furnace()


func handle_stage_updated(stage: GameManager.CraftingStage) -> void:
	if stage == GameManager.CraftingStage.FURNACE:
		init_stage()

func init_stage() -> void:
	thermometer.show()
	thermometer_progress.value = 0
	heat_decrease_timer.start()


func heat_furnace() -> void:
	if !_can_heat: return
	
	_can_heat = false
	
	increase_heat()
	manage_success_timer()
	handle_overheat()



func increase_heat() -> void:
	thermometer_progress.value += heat_power
	heat_sound.play()
	heat_timeout_timer.start()
	show_fire_in_forge()


func show_fire_in_forge() -> void:
	if thermometer_progress.value > 0 and forge_without_fire.visible:
		forge_without_fire.hide()


func hide_fire_in_forge() -> void:
	if !forge_without_fire.visible:
		forge_without_fire.show()


func manage_success_timer() -> void:
	if thermometer_progress.value >= min_heat and success_timer.is_stopped():
		success_timer.start(time_to_succeed)


func handle_overheat() -> void:
	if thermometer_progress.value >= max_heat:
		start_or_resume_overheat_timer()
	elif thermometer_progress.value < max_heat and !overheat_timer.is_stopped():
		pause_overheat_timer()


func start_or_resume_overheat_timer() -> void:
	if overheat_timer.is_stopped():
		overheat_timer.start(time_to_overheat)
	elif overheat_timer.paused:
		overheat_timer.paused = false


func pause_overheat_timer() -> void:
	overheat_timer.paused = true


func stop_success_timer() -> void:
	success_timer.stop()


func stop_overheat_timer() -> void:
	overheat_timer.stop()


func stop_heat_decrease_timer() -> void:
	heat_decrease_timer.stop()


func on_ore_process_success() -> void:
	stop_stage()
	pick_up_item.handle_picked_up()
	SignalHub.emit_ore_heat_passed()


func on_ore_process_fail() -> void:
	fail_sound.play()
	stop_stage()
	SignalHub.emit_ore_heat_failed()


func stop_stage() -> void:
	stop_success_timer()
	stop_overheat_timer()
	stop_heat_decrease_timer()
	thermometer.hide()
	thermometer_progress.value = 0
	hide_fire_in_forge()

func _on_heat_timeout_timer_timeout() -> void:
	_can_heat = true


func _on_heat_decrease_timer_timeout() -> void:
	thermometer_progress.value -= heat_decrease_power
	
	if thermometer_progress.value <= max_heat:
		pause_overheat_timer()
	
	if thermometer_progress.value <= min_heat:
		stop_success_timer()
	
	if thermometer_progress.value <= 0:
		hide_fire_in_forge()
		stop_overheat_timer()


func _on_success_timer_timeout() -> void:
	on_ore_process_success()


func _on_overheat_timer_timeout() -> void:
	on_ore_process_fail()
