extends PlayerState
class_name PlayerAttack

var duration: float = 0.75

func _ready():
	animation_name = "attack"

func enter():
	duration = 0.5
	play_animation()
	player.attack()

func exit():
	pass

func update(delta):
	if !player.is_on_floor():
		emit_signal("transitioned", self, "PlayerAir")
	if duration > 0:
		duration -= delta
	else:
		emit_signal("transitioned", self, "PlayerIdle")
	
	player.apply_friction()

func _input(_event):
	pass
