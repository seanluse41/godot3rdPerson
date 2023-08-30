extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func _ready():
	Signals.loadingStarted.connect(_changeSceneAnimation)

func _changeSceneAnimation(_newScene):
	animation_player.play("dissolve")
	await Signals.loadingFinished
	animation_player.play_backwards("dissolve")
	await animation_player.animation_finished
	Signals.animationFinished.emit()
