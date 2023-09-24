extends Node

class_name DamageInfo

enum DamageType
{
	Physical,
	Magical,
	Pure
}

var amount: float
var knockback_strenght: float
var type: DamageType
