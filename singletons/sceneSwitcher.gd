extends Node

var currentScene = null
func _ready():
	var root = get_tree().root
	currentScene = root.get_child(root.get_child_count() -1)

func switchScene(nextScene):
	call_deferred("_deferredSwitchScene", nextScene)

func _deferredSwitchScene(nextScene):
	Signals.loadingStarted.emit()
	currentScene.queue_free()
	var s = ResourceLoader.load(nextScene, "PackedScene",ResourceLoader.CACHE_MODE_IGNORE)
	currentScene = s.instantiate()
	get_tree().root.add_child(currentScene)
	get_tree().current_scene = currentScene
	await get_tree().create_timer(1).timeout
	Signals.loadingFinished.emit()
