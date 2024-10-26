extends Node

@export var bullet_scene: PackedScene

var y_offset: float = 75.0

func shoot(player_position: Vector2, player_direction: int):
	if bullet_scene != null:
		var bullet = bullet_scene.instantiate() as Node2D
		bullet.position = player_position
		bullet.position.y -= y_offset
		bullet.set_direction(player_direction)
		get_parent().add_child(bullet)
