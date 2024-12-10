extends Node2D
class_name level

func _ready():
	get_tree().paused = false
	Global.score = 0
	$Help.show_help("Usa las FLECHAS IZQUIERDA y DERECHA para MOVERTE.",0.5)
	$Audio/Background.play()
	$GUI/Pause.hide()
	$GUI/Victory.hide()
	$GUI/GameOver.hide()

func _on_background_finished():
	$Audio/Background.play()

