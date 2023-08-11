extends Control
@onready var label = $MarginContainer/Panel/MarginContainer/Label

@onready var text: String
var isAnimating: bool = false
var tween

func _ready():
	Signals.textStarted.connect(_addText)
	Signals.textSkip.connect(_handleSkipText)
	Signals.textClose.connect(_closeTextBox)

func _process(_delta):
	if label.visible_ratio < 1.0:
		isAnimating = true
	else:
		isAnimating = false

func _openTextBox():
	self.show()
	
func _addText(newText):
	_openTextBox()
	label.text = newText
	_animateText()

func _animateText():
	tween = create_tween()
	tween.connect("finished",Callable(self,"_effectCompleted"))
	tween.tween_property(label, "visible_ratio", 1.0, label.text.length() / 10)
	isAnimating = true

func _effectCompleted():
	isAnimating = false
	Signals.textFinished.emit()
	
func _closeTextBox():
	self.hide()
	label.visible_ratio = 0.0

func _handleSkipText():
	if isAnimating:
		tween.set_speed_scale(10.0)
	else:
		_closeTextBox()
