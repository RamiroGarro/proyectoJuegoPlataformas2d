extends Control

func _ready():
	$Buttons/Start.grab_focus()	
	$Music.play()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/level.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
