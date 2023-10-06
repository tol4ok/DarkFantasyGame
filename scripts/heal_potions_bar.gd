extends HBoxContainer

@export var heal_potion: PackedScene = preload("res://scenes/heal_potion_texture.tscn")
@export var player: Player

func _ready():
	player.heal_used.connect(_on_player_heal_used)
	
	var count_to_add = player.heals_remain - get_child_count()
	if count_to_add < 1: return
	for i in count_to_add:
		var instance = heal_potion.instantiate()
		add_child(instance)

func _on_player_heal_used():
	remove_child(get_child(0))
