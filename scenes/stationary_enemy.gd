extends Area2D

var health := 3

func _ready():
	#connect("body_entered", Callable(self, "_on_body_entered"))
	modulate = Color(1,1,1,1)

func take_damage():
	if health > 0:
		health -= 1
		update_tint()

	if health <= 0:
		die()

func update_tint():
	var red_tint := 1 - (health * 0.33)
	modulate = Color(1, red_tint, red_tint, 1)


func die():
	queue_free()
