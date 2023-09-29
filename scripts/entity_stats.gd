extends Node
class_name EntityStats

signal health_changed(new_value: float, applied_value: float)

static var gravity = 9.8

@export var health_bar: ColorRect
@export var movement_speed: float

var friction: float
var acceleration: float

var jump_force: float
var current_health: float
var max_health: float
var armour: int

func _init():
	movement_speed = 150
	friction = 32
	acceleration = 32
	
	jump_force = 200
	current_health = 10
	max_health = 10
	armour = 1

func change_health(amount: float):
	current_health = clampf(current_health + amount, 0, max_health)
	if health_bar: health_bar.scale.x = current_health / max_health

func recieve_damage(damage: DamageInfo):
	change_health(-damage.amount)
	emit_signal("health_changed", current_health, damage.amount)
	#print("Health changed to ", current_health)

func recieve_heal(amount: float):
	change_health(amount)
	emit_signal("health_changed", current_health, amount)
	#print("Health changed to ", current_health)
