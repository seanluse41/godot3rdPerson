extends Control
@onready var can = $MarginContainer/Panel/can
@onready var canNot = $MarginContainer/Panel/canNot


func canInteract():
	can.show()
	canNot.hide()

func canNotInteract():
	can.hide()
	canNot.show()
