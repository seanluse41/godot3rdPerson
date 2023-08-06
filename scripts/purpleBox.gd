extends Interactable

func onInteract():
	_interactionStart(func(): orangeBox())

func orangeBox():
	print(self, "interacted")
	Signals.interactionFinished.emit()
