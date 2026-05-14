extends State

enum PunchComboState {
	NONE,
	PUNCH_1,
	PUNCH_2,
	PUNCH_3,
	RECOVERY
}

@onready var animation_player = $"../../PlayerAnimations"

var combo_state: PunchComboState = PunchComboState.NONE
var combo_inc : int = 0
var punch_ready : bool
@onready var debug_label = $"../../DebugLabel"

func enter() -> void:
	super()

	punch_ready = false
	combo_state = PunchComboState.PUNCH_1
	combo_inc = 0
	#start_combo_state()
	parent.player_animations.play("punch")


func _process(delta):
	debug_label.text = str(combo_inc)


func exit() -> void:
	super()

	combo_state = PunchComboState.NONE
	#combo_buffered = false
	#combo_window_open = false

func physics_update(_delta: float) -> State:
	return null


func advance_combo() -> void:
	if punch_ready:
		combo_inc += 1
		match combo_inc:
			1:
				print("Punch 1")
				parent.player_animations.stop()
				parent.player_animations.play("punch")
			2:
				print("Punch 2")
				parent.player_animations.play("punch1")
			3:
				print("Punch 3")
				parent.player_animations.play("punch2")
	else:
		print("too early")


#
## Called from animation method track
#func open_combo_window() -> void:
	#combo_window_open = true
#
#
## Called from animation method track
#func close_combo_window() -> void:
	#combo_window_open = false

#
## Called from animation method track
#func advance_combo() -> void:
#
	#if combo_window_open and combo_buffered:
#
		#combo_buffered = false
#
		#match combo_state:
#
			#PunchComboState.PUNCH_1:
				#combo_state = PunchComboState.PUNCH_2
				#start_combo_state()
#
			#PunchComboState.PUNCH_2:
				#combo_state = PunchComboState.PUNCH_3
				#start_combo_state()
#
			#PunchComboState.PUNCH_3:
				#combo_state = PunchComboState.RECOVERY
				#start_combo_state()
#
	##else:
		#finish_combo()

func enable_punch():
	punch_ready = true


func disable_punch():
	punch_ready = false
# Called from final animation frame
#func finish_combo() -> void:
#
	#combo_state = PunchComboState.NONE
	#combo_buffered = false
	#combo_window_open = false
#
	#state_machine.change_state(idle_state)
