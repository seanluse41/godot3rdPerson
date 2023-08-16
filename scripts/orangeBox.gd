extends Interactable

@export var puzzleResource: Resource

func onInteract():
	_interactionStart(func(): orangeBox())

func orangeBox():
	await SceneSwitcher.switchScene(puzzleResource.path)
	_interactionFinished()

func _on_area_3d_body_entered(_body):
	canInteract = false
	_canInteract(self)

func _on_area_3d_body_exited(_body):
	_leftInteractArea()

func _solve():
	puzzleResource._puzzleSolved()
