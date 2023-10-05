extends CharacterBody2D
class_name Player

@onready var sprite = $AnimatedSprite2D
@onready var hit_box: Area2D = $HitBox
@onready var upper_body_collision = $UpperBodyCollision
@onready var stats: EntityStats = $EntityStats
@onready var state_machine: StateMachine = $StateMachine
@onready var particles = $GPUParticles2D
# ------------ #
# --- TEMP --- #
var damage_test = DamageInfo.new(4, 2, DamageInfo.DamageType.Physical)
# --- TEMP --- #
# ------------ #
var input_x: float = 0
var is_crouch: bool = false

func _ready():
	pass

func _physics_process(_delta):
	input_x = -(Input.get_action_strength("move_left") - Input.get_action_strength("move_right"))
	move_and_slide()

func _input(event):
	if Input.is_action_just_pressed("jump") and is_on_floor() and not(get_state() is PlayerHurt):
		jump()
	if event.is_action_pressed("move_left"):
		flip_to_left(true)
	elif event.is_action_pressed("move_right"):
		flip_to_left(false)
	if event.is_action_pressed("crouch"):
		is_crouch = true
	elif event.is_action_released("crouch"):
		is_crouch = !is_crouch
	# ------------ #
	# --- TEMP --- #
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1: hurt(damage_test)
			KEY_2: stats.recieve_heal(1)
	# --- TEMP --- #
	# ------------ #

func get_state() -> PlayerState:
	return state_machine.current_state

func flip_to_left(is_left: bool):
	particles.process_material.gravity.x = -100 if is_left else 100 
	sprite.flip_h = is_left
	hit_box.position.x = -21 if is_left else 21

func jump():
	velocity.y = -stats.jump_force

## todo: Remove a state switching from the Player's class
func hurt(damage: DamageInfo):
	stats.recieve_damage(damage)
	state_machine.current_state.transitioned.emit(state_machine.current_state, "PlayerHurt")

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
	velocity.x = move_toward(velocity.x, input_x * stats.movement_speed, stats.acceleration)

func set_upper_collision_disabled(_is_active: bool):
	upper_body_collision.disabled = _is_active
