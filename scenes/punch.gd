extends State

func enter() -> void:
	super()
	#if parent.is_on_floor():
	parent.player_animations.play("punch")
