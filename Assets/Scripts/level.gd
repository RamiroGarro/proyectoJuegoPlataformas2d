extends Node2D

func _ready():
	get_tree().paused = false
	Global.score = 0
	$Audio/Background.play()
	$GUI/Pause.hide()
	$GUI/Victory.hide()
	$GUI/GameOver.hide()

func _on_background_finished():
	$Audio/Background.play()

