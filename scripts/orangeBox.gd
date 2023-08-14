extends Interactable

@export var orangeBoxPuzzle: PackedScene
@export var solved: bool = false

func onInteract():
	_interactionStart(func(): orangeBox())

func orangeBox():
	await SceneSwitcher.switchScene(orangeBoxPuzzle.resource_path)
	_interactionFinished()

func _on_area_3d_body_entered(_body):
	canInteract = false
	_canInteract(self)

func _on_area_3d_body_exited(_body):
	_leftInteractArea()
