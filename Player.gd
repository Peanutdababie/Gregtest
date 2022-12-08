extends KinematicBody2D

export(PackedScene) var BOTTLE: PackedScene = preload("res://Projectiles/PlayerBottle.tscn")

onready var attackTimer = $AttackTimer

var water_count = 5

const UP = Vector2(0,-1)
const GRAVITY = 20
const MAXFALLSPEED = 500
const MAXSPEED = 175
const JUMPFORCE = 400
const ACCEL = 10

var motion = Vector2()
var facing_right = true

func _ready():
	pass 

func _physics_process(delta):
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
		
	if facing_right == true:
		$Sprite.scale.x = -1
	else:
		$Sprite.scale.x = 1
	
	motion.x = clamp(motion.x,-MAXSPEED,MAXSPEED)
	
	if Input.is_action_pressed("right"):
		motion.x += ACCEL
		facing_right = true
		$AnimationPlayer.play("Run")
	elif Input.is_action_pressed("left"):
		motion.x -= ACCEL
		facing_right = false
		$AnimationPlayer.play("Run")
	else:
		motion.x = lerp(motion.x,0,0.2)
		$AnimationPlayer.play("Idle")
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMPFORCE
		if !is_on_floor():
			if motion.y < 0:
				$AnimationPlayer.play("Jump")
			elif motion.y > 0:
				$AnimationPlayer.play("Fall")
	
	motion = move_and_slide(motion,UP)
	
	if Input.is_action_just_pressed("action_attack") and water_count > 0:
		var bottle_direction = self.global_position.direction_to(get_global_mouse_position())
		throw_bottle(bottle_direction)
		water_count = water_count - 1

func throw_bottle(bottle_direction: Vector2):
	if BOTTLE:
		var bottle = BOTTLE.instance()
		get_tree().current_scene.add_child(bottle)
		bottle.global_position = self.global_position
		
		var bottle_rotation = self.global_position.direction_to(get_global_mouse_position()).angle()
		bottle.rotation = bottle_rotation
		
		attackTimer.start()
