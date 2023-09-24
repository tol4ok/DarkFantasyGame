extends Control

@onready var packed_test_scene = preload("res://scenes/test_scene.tscn")
@onready var play_button = $ButtonsContainer/PlayButton

func _ready():
	play_button.button_up.connect(on_play_button_up)
	

func on_play_button_up():
	get_tree().change_scene_to_packed(packed_test_scene)
	

func on_settings_button_up():
	pass

func on_exit_button_up():
	get_tree().unload_current_scene()

func _exit_tree():
	play_button.button_up.disconnect(on_play_button_up)
	
