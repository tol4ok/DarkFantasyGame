extends PlayerState
class_name PlayerCrouch

func _ready():
	animation_name = "crouch_idle"

func enter():
	play_animation()
	player.shrinck_collision()

func exit():
	player.unshrink_collision()

func update(_delta):
	if !player.is_on_floor():
		emit_signal("transitioned", self, "PlayerAir")
	if !player.is_crouch:
		emit_signal("transitioned", self, "PlayerIdle")
	if player.input_x != 0:
		emit_signal("transitioned", self, "PlayerRoll")
	
	player.apply_friction()
