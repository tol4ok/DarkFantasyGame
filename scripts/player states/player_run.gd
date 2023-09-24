extends PlayerState
class_name PlayerRun

func _ready():
	animation_name = "run"

func enter():
	play_animation()
	player.particles.set_emitting(true)

func exit():
	player.particles.set_emitting(false)

func update(_delta):
	if player.input_x == 0:
		emit_signal("transitioned", self, "PlayerIdle")
	if !player.is_on_floor():
		emit_signal("transitioned", self, "PlayerAir")
	if player.is_crouch:
		emit_signal("transitioned", self, "PlayerSlide")
		
	player.apply_acceleration()
