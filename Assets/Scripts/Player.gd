extends CharacterBody2D
class_name Player

var axis : Vector2 = Vector2.ZERO
var death : bool = false
var sword_attack : bool = false

@export_category("⚙️ Config")
@export_group("Required References")
@export var gui : CanvasLayer

@export_group("Motion")
@export var speed : int = 120
@export var gravity : int = 12
@export var jump : int = 352

func _process(_delta):
	match death:
		true:
			death_ctrl()
		false:
			motion_ctrl()

func _input(event):
	if not death and is_on_floor() and event.is_action_pressed("ui_accept"):
		jump_ctrl(1)
		
	if not death and event.is_action_pressed("ui_attack") and is_on_floor():
		sword_attack_ctrl()
					
func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	return axis.normalized()

func motion_ctrl() -> void:
	'''MOVIMIENTO'''
	if not get_axis().x == 0:
		$Sprites.scale.x = get_axis().x
	
	velocity.x = get_axis().x * speed
	velocity.y += gravity
	
	move_and_slide()
	
	'''ANIMACIONES'''
	match is_on_floor():
		true:
			if sword_attack == false:
				if not get_axis().x == 0:
					$Sprites.set_animation("Run")
				else:
					$Sprites.set_animation("Idle")
		false:
			if velocity.y < 0:
				$Sprites.set_animation("Jump")
			else:
				$Sprites.set_animation("Fall")
	$Sprites.play()
				
func death_ctrl() -> void:
	velocity.x = 0
	velocity.y += gravity
	move_and_slide()
	
func jump_ctrl(power : float) -> void:
	if is_on_floor():
		velocity.y = -jump * power
		$Audio/Jump.play()
		
func sword_attack_ctrl() -> void:
	sword_attack = true
	$Sprites.set_animation("Attack")
	$Sprites.play()	
	$Audio/Hit.play()
	
func damage_ctrl() -> void:
	death = true
	$Sprites.set_animation("Death")
	$Audio/Death.play()
	
func _on_hit_box_body_entered(body):
	'''if body is Enemigo and sword_attack == true :
		$Audio/Hit.play()
		body.damage_ctrl(1)
	'''			
	
func _on_sprites_animation_finished():
	if $Sprites.animation == "Death":
		gui.game_over()
	if $Sprites.animation == "Attack":
		sword_attack = false


