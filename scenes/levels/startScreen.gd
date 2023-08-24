extends Node3D

@onready var player = $player
@onready var animationPlayer = player.get_node("visuals/mixamo_base/AnimationPlayer")
var animations = [
	"idle",
	"walking",
	"get_up",
	"running",
	"kick",
	"fall_down"
]

func _ready():
	animationPlayer.play("walking")

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _on_timer_timeout():
	animations.shuffle()
	animationPlayer.play(animations[0])
