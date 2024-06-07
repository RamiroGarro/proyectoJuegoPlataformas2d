extends Node2D

@onready var sprite = $Sprite
@onready var explosion_animation = $AnimatedSprite
@onready var collision_area = $Area2D

func _ready():
	collision_area.body_entered.connect(_on_Bomb_body_entered)

func _on_Bomb_body_entered(body):
	if body.name == "Player":
		explode()

func explode():
	collision_area.monitoring = false
	sprite.visible = false
	explosion_animation.visible = true
	explosion_animation.play("explode")
	await explosion_animation.finished
	queue_free()
