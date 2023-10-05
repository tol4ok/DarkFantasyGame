extends PlayerState
class_name PlayerRoll

var duration: float = 0.5

func _ready():
	animation_name = "roll"

func enter():
	play_animation()
	duration = 0.5
	player.set_upper_collision_disabled(true)
	player.velocity.x = 200 * player.input_x
	player.stats.friction = 1.5

func exit():
	player.set_upper_collision_disabled(false)
	player.stats.friction = 32

func update(delta):
	if !player.is_on_floor():
		emit_signal("transitioned", self, "PlayerAir")
	if duration > 0:
		duration -= delta
	elif player.is_crouch:
		emit_signal("transitioned", self, "PlayerCrouch")
	else:
		emit_signal("transitioned", self, "PlayerIdle")
	
	player.apply_friction()
