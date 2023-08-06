extends Control
@onready var label = $MarginContainer/Panel/MarginContainer/Label

signal animationRunning
signal animationFinished

func _ready():
	pass
	#addText("TEST TEXT IN THE METAVERSE POPPING OFF SO HOT")

#func addText(newText):
	#label.text = newText
	#animateText()
#
#func animateText():
	#var tween = create_tween()
	#tween.connect("finished",Callable(self,"effectCompleted"))
	#tween.tween_property(label, "visible_ratio", 1.0, label.text.length() / 10)
#
#func effectCompleted():
	#emit_signal("animationFinished")
