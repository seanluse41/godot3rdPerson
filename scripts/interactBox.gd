extends Control
@onready var can = $MarginContainer/Panel/can
@onready var cant = $MarginContainer/Panel/cant


func canInteract():
	can.show()
	cant.hide()

func cantInteract():
	can.hide()
	cant.show()
