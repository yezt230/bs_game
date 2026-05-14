extends CharacterBody2D

const RADIUS = 6.0
const COLOR = Color(1, 0, 0)
#movement should use a vector? not sure
const MOVE_SPEED = 800

var direction = Vector2.RIGHT

@onready var timer = $Timer

func _process(_delta):
	move_bullet()
	

func _ready():
	_draw()


func _draw():
	draw_circle(Vector2.ZERO, RADIUS, COLOR)


func set_direction(updated_direction: int):
	direction = updated_direction


func move_bullet():
	velocity.x = direction * MOVE_SPEED
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		#print("damage")
		
		if collision.get_collider().is_in_group("enemies"):
			#print("damage dealt")
			collision.get_collider().take_damage()
			#print("Collided with: ", collision.get_collider().name)
		queue_free()


func _on_timer_timeout():
	queue_free()
