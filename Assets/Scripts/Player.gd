extends CharacterBody2D
class_name Player

var axis : Vector2 = Vector2.ZERO
var death : bool = false
var sword_attack : bool = false

@export_category("Config")
@export_group("Required References")
@export var gui : CanvasLayer

@export_group("Motion")
@export var speed : int = 120
@export var gravity : int = 12
@export var jump : int = 350

func _process(_delta):
	match death:
		true:
			death_ctrl()
		false:
			motion_ctrl()

func _input(event):
	if not death and is_on_floor() and event.is_action_pressed("ui_accept"):
		jump_ctrl()
		if not death and event.is_action_pressed("ui_attack"):
			sword_attack_ctrl()
		
func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	return axis.normalized()

func motion_ctrl() -> void:
	'''MOVIMIENTO'''
	if not get_axis().x == 0:
		$Sprite.scale.x = get_axis().x
	
	velocity.x = get_axis().x * speed
	velocity.y += gravity
	
	move_and_slide()
	
	'''ANIMACIONES'''
	
	match is_on_floor():
		true:
			if not get_axis().x == 0:
				$Sprite.set_animation("Run")
			else:
				$Sprite.set_animation("Idle")
		false:
			if velocity.y < 0:
				$Sprite.set_animation("Jump")
			else:
				$sprite.set_animation("Fall")
				
func death_ctrl() -> void:
	velocity.x = 0
	velocity.y += gravity
	move_and_slide()
	
	
func jump_ctrl() -> void:
	if is_on_floor():
		velocity.y = -jump * 1
		$Audio/Jump.play()
		
func sword_attack_ctrl() -> void:
	sword_attack = true
	$Sprite.set_animation("Attack")
	$Audio/Hit.play()
	
func damage_ctrl() -> void:
	death = true
	$Sprite.set_animation("Death")
	$Audio/Death.play()
	
func _on_sword_attack_animation_finished():
	sword_attack = false
	
func _on_sprite_animation_finished():
	if $Sprite.animation == "Death":
		gui.game_over()

func _on_sprites_animation_finished():
	pass # Replace with function body.
