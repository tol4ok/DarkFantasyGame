extends EnemyState
class_name EnemyIdle

func _ready():
	animation_name = "idle"

func enter():
	play_animation()

func exit():
	pass

func update(_delta):
	if !enemy.is_on_floor():
		emit_signal("transitioned", self, "EnemyAir")
	if enemy.direction != 0:
		emit_signal("transitioned", self, "EnemyRun")
	
	enemy.apply_friction()

func _input(_event):
	pass
