extends State
class_name playerWalk

signal walking

@onready var animation_player = %AnimationPlayer

func _enterState() -> void:
	set_physics_process(true)
	animation_player.play("Run")
