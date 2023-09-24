extends CharacterBody2D
class_name Player

@onready var sprite = $AnimatedSprite2D
@onready var hit_box: Area2D = $HitBox
@onready var upper_body_collision = $UpperBodyCollision
@onready var stats: EntityStats = $EntityStats
@onready var state_machine: StateMachine = $StateMachine

@onready var particles = $GPUParticles2D

var input_x: float = 0
var is_crouch: bool = false

func _ready():
	pass

func _physics_process(_delta):
	input_x = -(Input.get_action_strength("move_left") - Input.get_action_strength("move_right"))
	move_and_slide()

func _input(event):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -stats.jump_force
	if event.is_action_pressed("move_left"):
		flip_to_left(true)
	elif event.is_action_pressed("move_right"):
		flip_to_left(false)
	if event.is_action_pressed("crouch"):
		is_crouch = true
	elif event.is_action_released("crouch"):
		is_crouch = !is_crouch

func flip_to_left(is_left: bool):
	particles.process_material.gravity.x = -100 if is_left else 100 
	sprite.flip_h = is_left
	hit_box.position.x = -21 if is_left else 21

func attack():
	for body in hit_box.get_overlapping_bodies():
		print_debug(body)

func apply_gravity():
	velocity.y += stats.gravity

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, stats.friction)
	
func apply_acceleration():
	velocity.x = move_toward(velocity.x, input_x * stats.movement_speed, stats.acceleration)
	
func shrinck_collision():
	upper_body_collision.disabled = true
	print_rich("[color=green]Collision shrinked[/color]")

func unshrink_collision():
	upper_body_collision.disabled = false
	print_rich("[color=green]Collision UNshrinked[/color]")
