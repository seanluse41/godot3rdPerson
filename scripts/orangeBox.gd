extends Interactable

@export var puzzleResource: Resource

func _ready():
	puzzleResource._loadData()

func onInteract():
	_interactionStart(func(): orangeBox())

func orangeBox():
	if get_tree().current_scene.scene_file_path == puzzleResource.path:
		_solve()
		await SceneSwitcher.switchScene(puzzleResource.returnPath)
		_interactionFinished()
	else:
		await SceneSwitcher.switchScene(puzzleResource.path)
		_interactionFinished()

func _on_area_3d_body_entered(_body):
	canInteract = false
	_canInteract(self)

func _on_area_3d_body_exited(_body):
	_leftInteractArea()

func _solve():
	puzzleResource._puzzleSolved(puzzleResource)
