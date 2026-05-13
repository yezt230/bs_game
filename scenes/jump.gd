extends State

@export var idle_state: State
@export var run_state: State

func enter() -> void:
	super()
	parent.velocity.y = -(parent.JUMP_FORCE)


func physics_update(_delta: float) -> State:	
#dislike having to use parent.velocity.y as an additional check
#see if you can get this to return idle_state wihout it
	if parent.is_on_floor() and parent.velocity.y == 0:
		return run_state if parent.velocity.x != 0 else idle_state
	return null
