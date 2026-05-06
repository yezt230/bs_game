extends State

@export var idle_state: State

func enter() -> void:
	super()
	print("jumped2")


func physics_update(_delta: float) -> State:
	if parent.is_on_floor():
		print("returned")
		#return run_state if parent.velocity.x != 0 else idle_state
		return idle_state
	return null
