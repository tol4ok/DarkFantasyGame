extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var stats: EntityStats = $EntityStats
@onready var view: Area2D = $View

func _ready():
	flip_to_left(true)
	view.body_entered.connect(on_body_entered_view)
	view.body_exited.connect(on_body_exited_view)

func _process(delta):
	pass

func flip_to_left(is_left: bool):
	sprite.flip_h = is_left
	sprite.offset.x = -19 if is_left else 19
	view.apply_scale(Vector2(-1, -1) if is_left else Vector2(1, 1))

func on_body_entered_view(body: Node2D):
	print(body, " entered the enemy's view")

func on_body_exited_view(body: Node2D):
	print(body, " exited the enemy's view")
