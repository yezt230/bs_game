extends CharacterBody2D

var health := 3

func _ready():
	modulate = Color(1,1,1)


func take_damage():
	print('damage taken')
	if health > 0:
		health -= 1
		update_tint()
		
	if health <= 0:
		die()
		

func update_tint():
	var red_tint := 0 + (health * 0.33)
	modulate = Color(1, red_tint, red_tint)
		
		
func die():
	queue_free()
