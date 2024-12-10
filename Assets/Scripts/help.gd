extends Area2D

@export var help_text: String
@export var help_time = 0
var active = false

func _ready():
	# Asegurarse de que el ColorRect esté inicialmente transparente
	$CanvasLayer/ColorRect.modulate.a = 0.0
	$CanvasLayer/ColorRect.visible = false
	
func _on_body_entered(body):
	if body is player and !active:
		show_help(help_text,help_time)

func show_help(texto: String, tiempo: int) -> void:
	print(help_time)
	active = true
	$CanvasLayer/ColorRect/Label.text = texto
	await fade_in()
	# Espera los 3 segundos antes de desaparecer
	await get_tree().create_timer(help_time).timeout
	await fade_out()
	active = false

# Transición para aparecer (ajustada a 1 segundo)
func fade_in() -> void:
	$CanvasLayer/ColorRect.visible = true
	var tween = create_tween()
	# Asegurarse de animar desde opacidad 0 a 1
	tween.tween_property($CanvasLayer/ColorRect, "modulate:a", 1.0, 1)
	await tween.finished

# Transición para desaparecer
func fade_out() -> void:
	var tween = create_tween()
	tween.tween_property($CanvasLayer/ColorRect, "modulate:a", 0.0, 1)  # Puedes ajustar también aquí si quieres
	await tween.finished
	$CanvasLayer/ColorRect.visible = false
