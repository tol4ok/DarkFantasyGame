extends EnemyState
class_name EnemyAttack

var duration: float = 0.5

func _ready():
	animation_name = "attack"

func enter():
	duration = 0.5
	play_animation()
	enemy.attack()

func exit():
	pass

func update(delta):
	if !enemy.is_on_floor():
		emit_signal("transitioned", self, "PlayerAir")
	if duration > 0:
		duration -= delta
	else:
		emit_signal("transitioned", self, "PlayerIdle")
	
	enemy.apply_friction()

func _input(_event):
	pass
