extends Node
class_name EntityStats

signal health_changed(new_value: float, applied_value: float)

static var gravity = 9.8

var movement_speed: float
var friction: float
var acceleration: float

var jump_force: float
var health: float
var armour: int

func _ready():
	movement_speed = 150
	friction = 32
	acceleration = 32
	
	jump_force = 200
	health = 10
	armour = 1

func recive_damage(damage: DamageInfo):
	health -= (damage.amount - armour)
	emit_signal("health_changed", health, damage.amount)

func recive_heal(amount: float):
	health += amount
	emit_signal("health_changed", health, amount)
