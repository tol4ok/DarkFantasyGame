extends CharacterBody2D
class_name Enemy

@onready var hit_box: Area2D = $HitBox
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var stats: EntityStats = $EntityStats
@onready var view: Area2D = $View

var direction: int = 0

# ------------ #
# --- TEMP --- #
var damage_test = DamageInfo.new(1, 2, DamageInfo.DamageType.Physical)
# --- TEMP --- #
# ------------ #

func _ready():
	flip_to_left(true)
	view.body_entered.connect(on_body_entered_view)
	view.body_exited.connect(on_body_exited_view)

func _process(_delta):
	move_and_slide()

func flip_to_left(is_left: bool):
	sprite.flip_h = is_left
	sprite.offset.x = -19 if is_left else 19
	view.apply_scale(Vector2(-1, -1) if is_left else Vector2(1, 1))

func on_body_entered_view(body: Node2D):
	print(body, " entered the enemy's view")

func on_body_exited_view(body: Node2D):
	print(body, " exited the enemy's view")

func attack():
	for body in hit_box.get_overlapping_bodies():
		if body is Enemy:
			body.stats.recieve_damage(damage_test)
		print("Attacked ", body)

func apply_gravity():
	velocity.y += stats.gravity

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, stats.friction)
	
func apply_acceleration():
	velocity.x = move_toward(velocity.x, direction * stats.movement_speed, stats.acceleration)
