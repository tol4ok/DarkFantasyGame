extends TextureProgressBar

@export var stats: EntityStats

func _ready():
	max_value = stats.max_health
	value = stats.max_health
	stats.health_changed.connect(_on_health_changed)

func _on_health_changed(_new_value, _applied_value):
	value = _new_value
