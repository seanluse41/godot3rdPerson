extends Interactable

@export var houseInnerScene: String
@export var nextTrack: AudioStream

func onInteract():
	_interactionStart(func(): house1Door())
func house1Door():
	await SceneSwitcher.switchScene(houseInnerScene)
	_interactionFinished()

func _on_area_3d_body_entered(_body):
	_canInteract(self)

func _on_area_3d_body_exited(_body):
	_leftInteractArea()
