extends CharacterBody2D

const RADIUS = 6.0
const COLOR = Color(1, 0, 0)
#movement should use a vector? not sure
const MOVE_SPEED = 800

var direction = Vector2.RIGHT

@onready var timer = $Timer

func _process(_delta):
	move_bullet()

#func _physics_process(delta):
	#var collision = move_and_collide(velocity * delta)
	#if collision:
		#print("collided with: ", collision.get_collider().name)


func _ready():
	_draw()
	#timer.start()


func _draw():
	draw_circle(Vector2.ZERO, RADIUS, COLOR)


func set_direction(updated_direction: int):
	#direction = updated_direction.normalized()
	direction = updated_direction


func move_bullet():
	#velocity.x = MOVE_SPEED
	velocity.x = direction * MOVE_SPEED
	#print("thingy")
	move_and_slide()
	for i in get_slide_collision_count():
		print("collided")
		var collision = get_slide_collision(i)
		print("Collided with: ", collision.get_collider().name)


func _on_timer_timeout():
	queue_free()
