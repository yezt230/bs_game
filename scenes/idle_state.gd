extends State

@export var jump_state: State

func enter() -> void:
	super()
	#parent.animation_player.play("idle")

func process_input(_event: InputEvent) -> State:
	if parent.is_on_floor() and Input.is_action_just_pressed(&"jump"):
		parent.velocity.y = -(parent.JUMP_FORCE)
		return jump_state
	else:
		return self
