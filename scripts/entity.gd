extends CharacterBody2D
class_name Entity

@onready var state_machine: StateMachine = $StateMachine
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var stats: EntityStats = $EntityStats

var move_direction: float = 0

func flip_sprite(_is_flipped: bool):
	sprite.flip_h = _is_flipped

func jump():
	velocity.y = -stats.jump_force

func apply_gravity():
	velocity.y += stats.gravity

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, stats.friction)

func apply_acceleration():
	velocity.x = move_toward(velocity.x, move_direction * stats.movement_speed, stats.acceleration)
