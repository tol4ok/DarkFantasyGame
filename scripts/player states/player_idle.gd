extends PlayerState
class_name PlayerIdle

func _ready():
	animation_name = "stand_idle"

func enter():
	play_animation()

func exit():
	pass

func update(_delta):
	if !player.is_on_floor():
		emit_signal("transitioned", self, "PlayerAir")
	if player.move_direction != 0:
		emit_signal("transitioned", self, "PlayerRun")
	if player.is_crouch:
		emit_signal("transitioned", self, "PlayerCrouch")
	
	player.apply_friction()

func _input(event):
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_E:
		emit_signal("transitioned", self, "PlayerAttack")
