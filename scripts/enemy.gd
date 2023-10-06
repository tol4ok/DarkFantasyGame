extends Entity
class_name Enemy

const ATTACK_COOLDOWN = 1.5

@onready var hit_box: Area2D = $HitBox
@onready var view: Area2D = $View

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
	flip_sprite(true)
	# --- TEMP --- #
	# ------------ #

func _process(delta):
	if attack_cooldown_timer > 0:
		attack_cooldown_timer -= delta
	else:
		attack_cooldown_timer = ATTACK_COOLDOWN
		attack()
	
	move_and_slide()

func flip_sprite(_is_flipped: bool):
	sprite.flip_h = _is_flipped
	sprite.offset.x = -19 if _is_flipped else 19
	view.apply_scale(Vector2(-1, 1) if _is_flipped else Vector2(1, 1))
	hit_box.apply_scale(Vector2(-1, 1) if _is_flipped else Vector2(1, 1))

func on_body_entered_view(_body: Node2D):
	print(_body, " entered the enemy's view")

func on_body_exited_view(_body: Node2D):
	print(_body, " exited the enemy's view")

## todo: Remove a state switching from the Enemy's class
func attack():
	state_machine.current_state.transitioned.emit(state_machine.current_state, "EnemyAttack")
