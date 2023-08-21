extends State

class_name playerIdle

@onready var animation_player = %AnimationPlayer

func idle():
	animation_player.play("Idle")
