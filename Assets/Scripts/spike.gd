extends Area2D

func _ready():
	$Sprites.play()

func _on_body_entered(body):
	if body is player:
		$Sound.play()
		body.damage_ctrl()
		
		
