extends Node
class_name EntityStats

signal health_changed(new_value: float, applied_value: float)

static var gravity = 9.8

var movement_speed: float
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

func recieve_damage(damage: DamageInfo):
	current_health -= damage.amount
	print("Health changed from ", current_health + damage.amount, " to ", current_health)
	emit_signal("health_changed", current_health, damage.amount)

func recieve_heal(amount: float):
	current_health += amount
	print("Health changed from ", current_health - amount, " to ", current_health)
	emit_signal("health_changed", current_health, amount)
