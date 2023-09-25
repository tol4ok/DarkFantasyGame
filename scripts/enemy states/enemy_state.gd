extends State
class_name EnemyState

var enemy: Enemy
var animation_name: String

func init(_object):
	enemy = _object

func play_animation():
	enemy.sprite.play(animation_name)
