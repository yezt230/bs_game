extends Node

@onready var player : CharacterBody2D = get_tree().get_nodes_in_group("player")[0]

@onready var state_machine = player.get_node("StateMachine")

func _ready():
	print(player)
	print(state_machine)


func return_to_idle():
	print("idled")
	if state_machine:
		state_machine.change_state($"../StateMachine/Idle")
	else:
		print("state not rec")
