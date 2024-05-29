extends Camera2D

@export_category("⚙️ Config")

@export_group("Required References")
@export var player : CharacterBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = player.global_position
