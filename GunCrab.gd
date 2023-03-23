extends KinematicBody2D

export(PackedScene) var BULLET: PackedScene = preload("res://Projectiles/EnemyBullet.tscn")

onready var attackTimer = $AttackTimer
onready var shoot_gun = $Position2D
onready var gun_position = $Position2D

var is_moving_left = true
var gravity =  20 
var velocity = Vector2(0, 0)

var speed = 80 # pixels per second

func _ready():
	$AnimationPlayer.play("Walk_Run")

func _process(_delta):
	if $AnimationPlayer.current_animation == ("Shoot"):
		return
	
	move_character()
	detect_turn_around()
	
func move_character():
	velocity.x = -speed if is_moving_left else speed
	velocity.y += gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)

func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x

func hit():
	$AttackDetector.monitoring = true

func end_of_hit():\
	$AttackDetector.monitoring = false
	
func start_run():
	$AnimationPlayer.play("Walk_Run")

func _on_PlayerDetector_body_entered(body):
	var new_bullet = BULLET.instance()
	new_bullet.position = shoot_gun.global_position
	get_tree().current_scene.add_child(new_bullet)
	attackTimer.start()

func _on_GunCrab_body_entered(body):
	queue_free()
