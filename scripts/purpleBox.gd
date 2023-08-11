extends Interactable

@export var testText: String

func onInteract():
	_interactionStart(func(): purpleBox())

func purpleBox():
	Signals.textStarted.emit(testText)
	await Signals.textFinished
	_interactionFinished()

func _on_area_3d_body_entered(_body):
	_canInteract(self)

func _on_area_3d_body_exited(_body):
	if TextBox.visible:
		TextBox._closeTextBox()
	_leftInteractArea()
