extends CanvasLayer

func _process(delta):
	$Container/Label.text = "SCORE: " + str(Global.score)

func game_over() -> void:
	#await get_tree().create_timer(1.5).timeout
	get_tree().paused = true
	$GameOver/Container/Buttons/Restart.grab_focus()
	var tween : Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property($GameOver,'modulate',Color(1,1,1,0.8),1.0)
	$GameOver/Sound.play()
	
func _on_restart_pressed():
	get_tree().reload_current_scene()

func _on_exit_pressed():
	get_tree().quit()
	 
func _on_resume_pressed():
	$Pause/Container/Buttons/Resume.release_focus()
	get_tree().paused = false
	var tween : Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property($Pause,'modulate',Color(1,1,1,0),1.0)

func _input(event):
	if event.is_action_pressed("ui_pause") and get_tree().paused == false:
		get_tree().paused = true
		$Pause/Container/Buttons/Resume.grab_focus()
		var tween : Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		tween.tween_property($Pause,'modulate',Color(1,1,1,0.8),1.0)
