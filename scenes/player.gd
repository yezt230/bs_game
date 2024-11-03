extends CharacterBody2D

const WALK_SPEED = 600
const STOP_FORCE = 1300
const MAX_SPEED = 400
const ACCELERATION = 1.2
const ACCEL_FORCE = 24
const DECEL_FORCE = ACCEL_FORCE * 2
const JUMP_FORCE = 1500

const SHOOT_OFFSET = Vector2(0, -130)
const DEFAULT_OFFSET = Vector2(0, -80)
#Better way to load & populate the scene with the bullet?
const BULLETSCENE = preload("res://scenes/bullet.tscn")

#signal bullet_direction(bullet_direction_var: String)

var move_speed = 0
var falling_speed = 0
var is_shooting = false
var is_crouching = false
var looking_up = false
#var facing_right = true
#var player_direction: Vector2 = Vector2.RIGHT
var player_direction = 1
var weapon_manager: Node = null

@onready var gravity := float(ProjectSettings.get_setting("physics/2d/default_gravity"))
#@onready var weapon_manager = $WeaponManager
@onready var top_sprite = $TopSprite
@onready var bottom_sprite = $BottomSprite	

func _ready():
	weapon_manager = get_parent().get_node("WeaponManager")


func _process(_delta):
	get_movement()
	if Input.is_action_just_pressed("shoot"):
		weapon_manager.shoot(position, player_direction)
		

func get_movement():	
	velocity.y += floor(gravity/16)
	
	# TODO: Refactor walk code
	var walk = Input.get_axis(&"move_left", &"move_right")
	if (walk != 0):		
		move_speed += floor(walk * ACCELERATION) + (walk * ACCEL_FORCE)
		#velocity.x = min(move_speed, MAX_SPEED)
		if walk > 0:
			#player_direction = Vector2.RIGHT
			player_direction = 1
		elif walk < 0: 
			#player_direction = Vector2.LEFT
			player_direction = -1
	else:
		if (move_speed > 0):
			move_speed -= floor(ACCELERATION) + DECEL_FORCE
			if move_speed < 0:
				move_speed = 0
		elif (move_speed < 0):
			move_speed += floor(ACCELERATION) + DECEL_FORCE
			if move_speed > 0:
				move_speed = 0
	move_speed = clamp(move_speed, -MAX_SPEED, MAX_SPEED)
	velocity.x = move_speed
	
	if Input.is_action_pressed("shoot"):
		is_shooting = true
	else:
		is_shooting = false
		
	if Input.is_action_pressed("crouch"):
		is_crouching = true
	else:
		is_crouching = false
				
	if Input.is_action_pressed("look_up"):
		looking_up = true
	else:
		looking_up = false
	
	if is_on_floor() and Input.is_action_just_pressed(&"jump"):
		velocity.y = -JUMP_FORCE
		
	update_animations(walk)	
	move_and_slide()	


func update_animations(input_axis):
	if input_axis != 0:
		all_sprites("flip_h", input_axis < 0)
		# TODO: this syncs the frame btwn top & bottom run animations
		#but the wrong frame plays for a split second, making it flicker
		if is_on_floor():
			top_sprite.frame = bottom_sprite.frame
			check_shooting_animation("run")
	else:
		if is_on_floor():
			if not is_crouching:
				check_shooting_animation("idle")
			else:
				check_shooting_animation("crouch")
		if looking_up and not is_shooting:		
			top_sprite.play("look_up")
	
	if not is_on_floor():
		if velocity.y > 150:
			#all_sprites("play", "jump_falling")
			check_shooting_animation("jump_falling")
		elif velocity.y <=150 and velocity.y > -150:
			#all_sprites("play", "jump_neutral")
			check_shooting_animation("jump_neutral")
		else:
			#all_sprites("play", "jump_rising")
			check_shooting_animation("jump_rising")
		#add jump
				

func check_shooting_animation(animation: String):
	if not is_shooting:
		all_sprites("play", animation)
		top_sprite.position = DEFAULT_OFFSET
	else:
		if top_sprite.animation != "shoot":
			if not looking_up:
				print("not looking up")
				top_sprite.play("shoot")
				if not is_crouching:
					top_sprite.position = SHOOT_OFFSET
			else:
				print("looking up")
				top_sprite.play("shoot_up")
		bottom_sprite.play(animation)		


func all_sprites(action: String, param = null):
	var sprites = [top_sprite, bottom_sprite] 
	
	for sprite in sprites:
		match action:
			"flip_h":
				sprite.flip_h = param
			"play":
				sprite.play(param)
