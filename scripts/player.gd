extends Entity
class_name Player

signal heal_used

@onready var hit_box: Area2D = $HitBox
@onready var upper_body_collision = $UpperBodyCollision
@onready var particles = $GPUParticles2D
# ------------ #
# --- TEMP --- #
var damage_test = DamageInfo.new(4, 2, DamageInfo.DamageType.Physical)
# --- TEMP --- #
# ------------ #

var is_crouch: bool = false
var heals_remain = 6;

func _ready():
	pass

func _physics_process(_delta):
	move_direction = -(Input.get_action_strength("move_left") - Input.get_action_strength("move_right"))
	move_and_slide()

func _input(event):
	if Input.is_action_just_pressed("jump") and is_on_floor() and not(get_state() is PlayerHurt):
		jump()
	if event.is_action_pressed("move_left"):
		flip_sprite(true)
	elif event.is_action_pressed("move_right"):
		flip_sprite(false)
	if event.is_action_pressed("crouch"):
		is_crouch = true
	elif event.is_action_released("crouch"):
		is_crouch = !is_crouch
	# ------------ #
	# --- TEMP --- #
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1: hurt(damage_test)
			KEY_2: heal(4)
	# --- TEMP --- #
	# ------------ #

func get_state() -> PlayerState:
	return state_machine.current_state

func flip_sprite(_is_flipped: bool):
	sprite.flip_h = _is_flipped
	particles.process_material.gravity.x = -100 if _is_flipped else 100 
	hit_box.position.x = -21 if _is_flipped else 21

## todo: Remove a state switching from the Player's class
func hurt(damage: DamageInfo):
	stats.damage(damage)
	state_machine.current_state.transitioned.emit(state_machine.current_state, "PlayerHurt")

func heal(amount: float):
	if heals_remain > 0:
		heals_remain -= 1
		stats.heal(amount)
		emit_signal("heal_used")

func attack():
	for body in hit_box.get_overlapping_bodies():
		if body is Enemy:
			body.stats.damage(damage_test)

func set_upper_collision_disabled(_is_active: bool):
	upper_body_collision.disabled = _is_active
