extends CharacterBody3D
class_name Player

@onready var visuals = $visuals
@onready var interact_box = $interactBox
@onready var camera_mount = $CameraMount
@onready var interact_timer = $interactBox/interactTimer
@onready var animation_player = %AnimationPlayer

@export var runningSpeed = 10.0
@export var SENSITIVITY_X = 0.4
@export var SENSITIVITY_Y = 0.01
@export var currentState : int = States.IDLE
enum States {IDLE, WALK, RUN, JUMP, INTERACT, SEARCH, LOCKED}

var SPEED = 3.0
const JUMP_VELOCITY = 4.5
var walkingSpeed = 4.0
var twistInput := 0.0
var pitchInput := 0.0
var isRunning = false
var isLocked = false
var canInteract = false
var currentInteractable
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Signals.interactionFinished.connect(_unlockCharacter)
	Signals.canInteract.connect(_handleCanInteractBox)
	Signals.canNotInteract.connect(_handleCanNotInteractBox)
	Signals.leftInteractArea.connect(_handleLeftInteractArea)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _changeState(newState):
	currentState = newState

func _input(event):
	if event is InputEventMouseMotion:
		twistInput = - event.relative.x * SENSITIVITY_X
		pitchInput = -event.relative.y * SENSITIVITY_Y
		rotate_y(deg_to_rad(twistInput))
		visuals.rotate_y(deg_to_rad(-twistInput))
		camera_mount.rotate_x(pitchInput)
		camera_mount.rotation.x = clamp(camera_mount.rotation.x, -0.6, 0)

func _handleSearch():
	if is_on_floor():
		if not isLocked:
			isLocked = true
			_unlockCharacter()

func _handleInteract():
	if TextBox.visible:
		Signals.textSkip.emit()
	else:
		interact()

func _handleRun():
	SPEED = runningSpeed

func _handleJump():
	velocity.y = JUMP_VELOCITY

func chooseAnimation():
	match currentState:
		States.IDLE:
			animation_player.play("Idle")
		States.WALK:
			animation_player.play("Run")
		States.RUN:
			animation_player.play("Sprint")
		States.JUMP:
			animation_player.play("Jump")
		States.SEARCH:
			animation_player.play("T-pose")
		States.INTERACT:
			animation_player.play("Idle")
		States.LOCKED:
			animation_player.play("Idle")
		_:
			animation_player.play("Idle")

func _physics_process(delta):
	chooseAnimation()
	if Input.is_action_pressed("search"):
		_changeState(States.SEARCH)
		_handleSearch()
	if Input.is_action_just_pressed("interact"):
		_changeState(States.INTERACT)
		_handleInteract()
	if Input.is_action_pressed("run"):
		_changeState(States.RUN)
		_handleRun()
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and currentState != States.LOCKED:
		_changeState(States.JUMP)
		_handleJump()

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3( -input_dir.x, 0, -input_dir.y)).normalized()
	if direction:
		visuals.look_at(direction)
		if currentState != States.LOCKED:
			visuals.look_at(position - direction)
		velocity.x = -direction.x * SPEED
		velocity.z = -direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if !isLocked:
		move_and_slide()

func _unlockCharacter():
	_changeState(States.IDLE)

func _handleCanInteractBox(node: Node):
	currentInteractable = node
	interact_box.show()
	interact_box.canInteract()
	canInteract = true

func _handleCanNotInteractBox(node: Node):
	currentInteractable = node
	interact_box.show()
	interact_box.canNotInteract()
	canInteract = false

func _handleLeftInteractArea():
	currentInteractable = null
	interact_box.hide()
	canInteract = false

func _resetInteract():
	if currentInteractable and canInteract:
		await Signals.interactionFinished
		interact_box.show()

func interact():
	if not canInteract:
		pass
	else:
		if currentInteractable.has_method("onInteract"):
			_changeState(States.LOCKED)
			currentInteractable.onInteract()
			interact_box.hide()
			interact_timer.start()

func _on_interact_timer_timeout():
	_resetInteract()

func _on_animation_player_animation_finished(_anim_name):
	_unlockCharacter()
