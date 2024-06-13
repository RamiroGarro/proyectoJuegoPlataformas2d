extends Node2D

func _on_body_entered(body):
	if body is player:
		$Sprites.play()
		await $Sprites.animation_finished
		$AreaExplosion/CollisionExplosion.disabled = false
		$Sprites.set_animation("explosion")
		$Sprites.play()
		$Sound.play()
		await $Sprites.animation_finished
		$AreaExplosion/CollisionExplosion.disabled = true
		self.queue_free()
	
func _on_area_explosion_body_entered(body):
	if body is player:
		body.damage_ctrl()

