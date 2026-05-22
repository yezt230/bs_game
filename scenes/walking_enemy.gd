extends CharacterBody2D

var health := 3
@onready var enemy_sprite = $EnemySprite

func _ready():
	modulate = Color(1,1,1)


func _process(delta):
	move_and_slide()


func take_damage():
	#print('damage taken')
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


func _on_hurtbox_area_entered(area):
	flash_enemy()


func flash_enemy():
	var tween := create_tween()

	enemy_sprite.modulate = Color(1, 0, 0)

	tween.tween_property(
		enemy_sprite,
		"modulate",
		Color(1, 1, 1),
		0.15
	)
	
