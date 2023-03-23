extends KinematicBody2D

var is_moving_left = true

var gravity =  20 
var velocity = Vector2(0, 0)

var speed = 80 # pixels per second

func _ready():
	$AnimationPlayer.play("Run")

func _process(_delta):
	if $AnimationPlayer.current_animation == ("knife"):
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
	$AnimationPlayer.play("Run")

func _on_PlayerDetector_body_entered(body):
	$AnimationPlayer.play("knife")

func _on_AttackDetector_body_entered(body):
	pass

func _on_HurtBox_body_entered(body):
	if body is Area2D:
		queue_free()
