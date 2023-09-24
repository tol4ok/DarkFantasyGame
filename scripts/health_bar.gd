extends Control

var max_rect_size = 10

func _on_entity_stats_health_changed(new_value, applied_value):
	print("health changed by ", applied_value, " new health value ", new_value)
	$ColorRect.size = Vector2(new_value, 3)
