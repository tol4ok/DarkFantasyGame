extends EnemyState
class_name EnemyAir

func _ready():
	animation_name = "jump"

func enter():
	play_animation()

func update(_delta):
	if enemy.is_on_floor() and enemy.direction != 0:
		emit_signal("transitioned", self, "PlayerRun")
	elif enemy.is_on_floor():
		emit_signal("transitioned", self, "PlayerIdle")
	
	enemy.apply_gravity()
	enemy.apply_acceleration()
