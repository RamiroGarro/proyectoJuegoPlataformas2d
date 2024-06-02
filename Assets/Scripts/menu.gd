extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/startButton.grab_focus()	
	BgsoundDungeon.play_music_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene("res://Scenes/menu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
