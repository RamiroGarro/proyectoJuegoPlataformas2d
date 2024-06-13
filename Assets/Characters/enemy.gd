extends CharacterBody2D
class_name Enemy

@export_category("Config")

@export_group("Options")
#indica puntos de vida de cada enemigo
@export var health : int = 1
#define el puntaje que le damos al matar al enemigo
@export var score : int = 100

@export_group("Motion")
@export var speed : int = 16
@export var gravity : int = 16

#no es un personaje controlable, se mueve solo
var direction : int = 1

func _physics_process(delta):
	
	if health > 0: #Esta vivo
		motion_ctrl()

func motion_ctrl() -> void:
	#escala del sprite = a la direccion
	$Sprite.scale.x = direction

	#detecta pared u obstaculo modifica direccion al opuesto
	if not $Sprite/RayGround.is_colliding() or is_on_wall():
		direction *= -1
	
	velocity.x = direction * speed
	#Empuja el personaje hacia abajo
	velocity.y += gravity
	move_and_slide()	

#Llamada por el player, pide parametro "damage", que corresponde al daño recibido
#El player le da mayor o menor daño
func damage_ctrl(damage : int) -> void:
	#Resta el daño a la vida
	health -= damage
		
	if health <= 0: #Se muere
		$Sprite.set_animation("Death")
		$Collision.set_deferred("disabled", true) #set_difered para que no tire advertencia
			
		gravity = 0 #El enemigo no se hunde en el suelo
		GLOBAL.score += score #sumamos el puntaje
			
func _on_sprite_animation_finished():
	if $sprite.animation == "Death":
			queue_free() #elimina el nodo
			
func _on_area_hit_body_entered(body):
	if body is Player and health>0:
		body.damage_ctrl()
	
	



