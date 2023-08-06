extends Node

var currentScene = null
func _ready():
	var root = get_tree().root
	currentScene = root.get_child(root.get_child_count() -1)
	print(currentScene)

func switchScene(nextScene):
	Signals.startLoading.emit()
	call_deferred("_deferredSwitchScene", nextScene)

func _deferredSwitchScene(nextScene):
	currentScene.queue_free()
	var s = ResourceLoader.load(nextScene)
	currentScene = s.instantiate()
	get_tree().root.add_child(currentScene)
	get_tree().current_scene = currentScene
	Signals.finishedLoading.emit()
