extends CharacterBody2D

const RADIUS = 6.0
const COLOR = Color(1, 0, 0)
#movement should use a vector? not sure
const MOVE_SPEED = 800

var direction = Vector2.RIGHT

@onready var timer = $Timer

func _process(_delta):
	move_bullet(_delta)
	

func _ready():
	#connect("body_entered", Callable(self, "_on_body_entered"))
	_draw()
	#timer.start()


func _draw():
	draw_circle(Vector2.ZERO, RADIUS, COLOR)


func set_direction(updated_direction: int):
	#direction = updated_direction.normalized()
	direction = updated_direction


func move_bullet(delta):
	#velocity.x = MOVE_SPEED
	velocity.x = direction * MOVE_SPEED
	#move_and_slide()
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#print("I collided with ", collision.get_collider().name)
	var collision = move_and_collide(velocity * delta)
	if collision:
		print("collied")

func _on_timer_timeout():
	queue_free()


#func _on_body_entered(body):
	#print("Collision detected2with:", body.name)
