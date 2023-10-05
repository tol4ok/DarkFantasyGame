extends PlayerState
class_name PlayerCrouch

func _ready():
	animation_name = "crouch_idle"

func enter():
	play_animation()
	player.set_upper_collision_disabled(true)

func exit():
	player.set_upper_collision_disabled(false)

func update(_delta):
	if !player.is_on_floor():
		emit_signal("transitioned", self, "PlayerAir")
	if !player.is_crouch:
		emit_signal("transitioned", self, "PlayerIdle")
	if player.input_x != 0:
		emit_signal("transitioned", self, "PlayerRoll")
	
	player.apply_friction()
