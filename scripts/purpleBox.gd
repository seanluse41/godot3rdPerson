extends Interactable

func onInteract():
	_interactionStart(func(): purpleBox())

func purpleBox():
	print(self, "interacted")
	_interactionFinished()

func _on_area_3d_body_entered(_body):
	_canInteract(self)

func _on_area_3d_body_exited(_body):
	_leftInteractArea()
