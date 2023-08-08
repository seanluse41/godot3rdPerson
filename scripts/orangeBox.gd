extends Interactable

func onInteract():
	_interactionStart(func(): orangeBox())

func orangeBox():
	print(self, "interacted")
	_interactionFinished()

func _on_area_3d_body_entered(body):
	_canNotInteract(self)

func _on_area_3d_body_exited(body):
	_leftInteractArea()
