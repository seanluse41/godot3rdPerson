class_name Interactable
extends Node

var canInteract := false

func _interactionStart(interaction: Callable):
	interaction.call()

func _interactionFinished():
	Signals.interactionFinished.emit()

func _canInteract(node):
	Signals.canInteract.emit(node)
	
func _canNotInteract(node):
	Signals.canNotInteract.emit(node)

func _leftInteractArea():
	Signals.leftInteractArea.emit()
