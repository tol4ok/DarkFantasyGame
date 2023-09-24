extends PlayerState
class_name PlayerSlide

var duration: float = 1.0

func _ready():
	animation_name = "slide"

func enter():
	play_animation()
	duration = 1.0
	player.shrinck_collision()
	player.velocity *= 1.4
	player.stats.friction = 1.5
	player.particles.set_emitting(true)

func exit():
	player.unshrink_collision()
	player.stats.friction = 32
	player.particles.set_emitting(false)

func update(delta):
	if !player.is_on_floor():
		emit_signal("transitioned", self, "PlayerAir")
	if duration > 0:
		duration -= delta
	elif player.is_crouch:
		emit_signal("transitioned", self, "PlayerCrouch")
	elif player.input_x != 0:
		emit_signal("transitioned", self, "PlayerRun")
	else:
		emit_signal("transitioned", self, "PlayerIdle")
	
	player.apply_friction()
