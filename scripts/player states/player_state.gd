extends State
class_name PlayerState

var player: Player
var animation_name: String

func init(object):
	player = object

func play_animation():
	player.sprite.play(animation_name)
