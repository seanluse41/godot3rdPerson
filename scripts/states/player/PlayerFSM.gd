extends StateMachine

func _ready():
	addState("idle")
	addState("move")
	addState("run")
	addState("jump")
	addState("locked")
	addState("search")
	call_deferred("setState", states.idle)

func _input(event):
	if event is InputEventMouseMotion:
		parent._handleMouse(event)
	if Input.is_action_pressed("search"):
		parent._handleSearch()
	if Input.is_action_just_pressed("interact"):
		parent._handleInteract()
	if Input.is_action_pressed("run"):
		parent._handleRun()
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("jump"):
		parent._handleJump()

func _stateLogic(delta):
	parent._handleMoveInput()
	parent._handleGravity(delta)
	parent._handleInput()

func _getTransition(delta):
	return null

func _enterState(newState, oldState):
	pass

func _exitState(oldState, newState):
	pass
