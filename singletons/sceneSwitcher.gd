extends Node

var currentScene = null
func _ready():
	var root = get_tree().root
	currentScene = root.get_child(root.get_child_count() -1)

func switchScene(nextScene):
	call_deferred("_deferredSwitchScene", nextScene)

func _deferredSwitchScene(nextScene):
	Signals.loadingStarted.emit()
	get_tree().change_scene_to_file(nextScene)
	await get_tree().create_timer(1).timeout
	Signals.loadingFinished.emit()

func _newGame():
	switchScene("res://scenes/levels/areas/field.tscn")
