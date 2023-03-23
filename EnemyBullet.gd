extends Area2D

export(PackedScene) var gun_position: PackedScene = preload("res://GunCrab.tscn")

var speed = 300

func _physics_process(delta):
	var direction = gun_position
	global_position += speed * direction * delta

func _on_EnemyBullet_area_entered(area):
	queue_free()

func _on_EnemyBullet_body_entered(body):
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
