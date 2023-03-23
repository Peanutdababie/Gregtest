extends KinematicBody2D

export(PackedScene) var BULLET: PackedScene = preload("res://Projectiles/EnemyBullet.tscn")

onready var attackTimer = $AttackTimer
onready var shoot_gun = $Position2D
onready var gun_position = $Position2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayerDetector_body_entered(body):
	var b = BULLET.instance()
	b.position = $Position2D.global_position
	b.rotation = $Position2D.global_rotation
	get_tree().current_scene.add_child(b)
	attackTimer.start()
	

func _on_SniperCrab_body_entered(body):
	queue_free()
