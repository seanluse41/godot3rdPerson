class_name Interactable
extends Node

func _interactionStart(interaction: Callable):
	interaction.call()
	await Signals.interactionFinished
	_interactionFinished()

func _interactionFinished():
	print("interaction finished")
