extends State

@export var run_state: State
@export var jump_state: State

func enter() -> void:
	super()
	#parent.animation_player.play("idle")

func process_input(_event: InputEvent) -> State:
	if parent.is_on_floor() and Input.is_action_just_pressed(&"jump"):
		return jump_state
	elif Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		return run_state
	else:
		return self
