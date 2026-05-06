extends State

@export var idle_state: State
@export var run_state: State

func enter() -> void:
	super()
	parent.velocity.y = -(parent.JUMP_FORCE)
	#print("jumped2")
#
#func _process(delta):
#

func physics_update(_delta: float) -> State:	
	#print(parent.is_on_floor(), " ", parent.velocity.y)
	if not parent.is_on_floor():
		if parent.velocity.y > 150:
			#all_sprites("play", "jump_falling")
			parent.check_shooting_animation("jump_falling")
		elif parent.velocity.y <=150 and parent.velocity.y > -150:
			#all_sprites("play", "jump_neutral")
			parent.check_shooting_animation("jump_neutral")
		else:
			#all_sprites("play", "jump_rising")
			parent.check_shooting_animation("jump_rising")
#dislike having to use parent.velocity.y as an additional check
#see if you can get this to return idle_state wihout it
	if parent.is_on_floor() and parent.velocity.y == 0:
		return run_state if parent.velocity.x != 0 else idle_state
	return null
