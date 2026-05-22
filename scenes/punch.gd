extends State

enum PunchComboState {
	NONE,
	PUNCH_1,
	PUNCH_2,
	PUNCH_3,
	RECOVERY
}

@onready var animation_player = $"../../PlayerAnimations"
@onready var punch_hitbox = $"../../PunchHitbox"
@onready var punch_collision : CollisionShape2D = $"../../PunchHitbox/CollisionShape2D"
@onready var debug_label = $"../../DebugLabel"

var combo_state: PunchComboState = PunchComboState.NONE
var combo_inc : int = 0
var punch_ready : bool

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


func enable_punch():
	punch_ready = true
	

func disable_punch():
	punch_ready = false
	punch_collision.disabled = true


func punch_collision_enabled():
	punch_collision.disabled = false
	
	
func punch_collision_disabled():
	punch_collision.disabled = true
