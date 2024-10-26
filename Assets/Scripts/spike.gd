extends Area2D
class_name spike

func _ready():
	$Sprites.play()

func _on_body_entered(body):
	if body is player:
		$Sound.play()
		body.damage_ctrl()
	if body is Enemy:	
		body.direction *= -1
