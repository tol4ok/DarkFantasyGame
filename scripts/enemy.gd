extends CharacterBody2D
class_name Enemy

const ATTACK_COOLDOWN = 1.5

@onready var state_machine: StateMachine = $StateMachine
@onready var hit_box: Area2D = $HitBox
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var stats: EntityStats = $EntityStats
@onready var view: Area2D = $View

var direction: int = 0
var attack_cooldown_timer: float = ATTACK_COOLDOWN

# ------------ #
# --- TEMP --- #
var damage_test = DamageInfo.new(1, 2, DamageInfo.DamageType.Physical)
# --- TEMP --- #
# ------------ #

func _ready():
	view.body_entered.connect(on_body_entered_view)
	view.body_exited.connect(on_body_exited_view)
	
	# ------------ #
	# --- TEMP --- #
	flip_to_left(true)
	# --- TEMP --- #
	# ------------ #

func _process(delta):
	if attack_cooldown_timer > 0:
		attack_cooldown_timer -= delta
	else:
		attack_cooldown_timer = ATTACK_COOLDOWN
		attack()
	
	move_and_slide()

func flip_to_left(is_left: bool):
	sprite.flip_h = is_left
	sprite.offset.x = -19 if is_left else 19
	view.apply_scale(Vector2(-1, 1) if is_left else Vector2(1, 1))
	hit_box.apply_scale(Vector2(-1, 1) if is_left else Vector2(1, 1))

func on_body_entered_view(body: Node2D):
	print(body, " entered the enemy's view")

func on_body_exited_view(body: Node2D):
	print(body, " exited the enemy's view")

func jump():
	velocity.y = -stats.jump_force

#
# todo: Remove a state switching from the Enemy's class
#
func attack():
	state_machine.current_state.transitioned.emit(state_machine.current_state, "EnemyAttack")

func apply_gravity():
	velocity.y += stats.gravity

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, stats.friction)
	
func apply_acceleration():
	velocity.x = move_toward(velocity.x, direction * stats.movement_speed, stats.acceleration)
