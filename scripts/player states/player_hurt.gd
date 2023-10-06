extends PlayerState
class_name PlayerHurt

var duration: float = 0.5

func _ready():
	animation_name = "hurt"

func enter():
	duration = 0.5
	play_animation()

func update(_delta):
	if !player.is_on_floor():
		emit_signal("transitioned", self, "PlayerAir")
	if duration > 0:
		duration -= _delta
	elif player.is_crouch:
		emit_signal("transitioned", self, "PlayerCrouch")
	elif player.move_direction != 0:
		emit_signal("transitioned", self, "PlayerRun")
	else:
		emit_signal("transitioned", self, "PlayerIdle")
		
	player.apply_friction()
	
