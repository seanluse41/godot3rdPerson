extends Interactable

@export var houseInnerScene: PackedScene
var canInteract := false

func onInteract():
	_interactionStart(func(): house1Door())

func house1Door():
	print(self, "interacted")
	if canInteract:
		SceneSwitcher.switchScene(houseInnerScene.resource_path)
		Signals.interactionFinished.emit()

func _on_area_3d_body_entered(body):
	canInteract = true

func _on_area_3d_body_exited(body):
	canInteract = false
