extends Node

class_name DamageInfo

enum DamageType
{
	Physical,
	Magical,
	Pure
}

func _init(_amount: float, _knockback_strenght: float, _type: DamageType):
	amount = _amount
	knockback_strenght = _knockback_strenght
	type = _type

var amount: float
var knockback_strenght: float
var type: DamageType
