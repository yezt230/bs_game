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

var move_speed = 0
var falling_speed = 0
var is_shooting = false
var is_crouching = false
var looking_up = false
var player_direction = 1
var weapon_manager: Node = null

@onready var gravity := float(ProjectSettings.get_setting("physics/2d/default_gravity"))
@onready var player_sprite : Sprite2D = $PlayerSprite
@onready var player_animations : AnimationPlayer = $PlayerAnimations
@onready var state_machine : Node = $StateMachine

@onready var player_sprite_scale = player_sprite.scale.x

func _ready():
	state_machine.init(self)
	weapon_manager = get_parent().get_node("WeaponManager")


func _process(_delta):
	get_movement()
	if Input.is_action_just_pressed("shoot"):
		weapon_manager.shoot(position, player_direction)
	$StateLabel.text = state_machine.get_current_state()
		

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

	player_sprite.scale.x = (player_direction * player_sprite_scale)
	
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
		
	move_and_slide()	
