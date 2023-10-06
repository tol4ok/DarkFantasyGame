extends PlayerState
class_name PlayerAir

func _ready():
	animation_name = "jump"

func enter():
	play_animation()

func update(_delta):
	if player.is_on_floor() and player.move_direction != 0:
		emit_signal("transitioned", self, "PlayerRun")
	elif player.is_on_floor():
		emit_signal("transitioned", self, "PlayerIdle")
	
	player.apply_gravity()
	player.apply_acceleration()
