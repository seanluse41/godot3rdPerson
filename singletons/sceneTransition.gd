extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func _ready():
	Signals.startLoading.connect(_changeSceneAnimation)

func _changeSceneAnimation():
	animation_player.play("dissolve")
	await Signals.finishedLoading
	animation_player.play_backwards("dissolve")
	await animation_player.animation_finished
	Signals.animationFinished.emit()
