extends Area2D

func _on_body_entered(body):
	if body is player:
		$AnimatedSprite2D.set_animation("moneda_desactiva")
		$SoundCoin.play()
		Global.score += 100
		$CollisionShape2D.disabled

func _on_sound_coin_finished():
	queue_free()
