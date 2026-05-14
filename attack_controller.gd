extends Node

@onready var player : CharacterBody2D = get_tree().get_nodes_in_group("player")[0]
@onready var state_machine = player.get_node("StateMachine")

func return_to_idle():
	if state_machine:
		state_machine.change_state($"../StateMachine/Idle")
