extends Interactable

@export var houseInnerScene: PackedScene

func onInteract():
	_interactionStart(func(): house1Door())

func house1Door():
	print(self, "interacted")
	await SceneSwitcher.switchScene(houseInnerScene.resource_path)
	_interactionFinished()

func _on_area_3d_body_entered(body):
	_canInteract(self)

func _on_area_3d_body_exited(body):
	_leftInteractArea()
