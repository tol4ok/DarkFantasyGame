extends EnemyState
class_name EnemyRun

func _ready():
	animation_name = "run"

func enter():
	play_animation()

func exit():
	pass

func update(_delta):
	if enemy.direction == 0:
		emit_signal("transitioned", self, "PlayerIdle")
	if !enemy.is_on_floor():
		emit_signal("transitioned", self, "PlayerAir")
		
	enemy.apply_acceleration()
