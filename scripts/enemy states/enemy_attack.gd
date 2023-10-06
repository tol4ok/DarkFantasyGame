extends EnemyState
class_name EnemyAttack

var duration: float = 1
var is_attacked: bool = false

func _ready():
	animation_name = "attack"

func enter():
	duration = 1
	is_attacked = false
	play_animation()

func exit():
	pass

func update(delta):
	if !enemy.is_on_floor():
		emit_signal("transitioned", self, "EnemyAir")
	if duration > 0:
		duration -= delta
	else:	
		emit_signal("transitioned", self, "EnemyIdle")
	
	if duration < 0.6 and not is_attacked:
		is_attacked = true
		for body in enemy.hit_box.get_overlapping_bodies():
			if body is Player:
				body.hurt(enemy.damage_test)
	
	enemy.apply_friction()

func _input(_event):
	pass
