extends CharacterBody3D

@onready var visuals = $visuals
@onready var interact_box = $interactBox
@onready var camera_mount = $CameraMount
@onready var interact_timer = $interactBox/interactTimer
@onready var animation_player = %AnimationPlayer


var SPEED = 3.0
const JUMP_VELOCITY = 4.5

var walkingSpeed = 4.0
@export var runningSpeed = 10.0
var twistInput := 0.0
var pitchInput := 0.0
var isRunning = false
var isLocked = false
var canInteract = false
var currentInteractable
@export var SENSITIVITY_X = 0.4
@export var SENSITIVITY_Y = 0.01

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Signals.interactionFinished.connect(_unlockCharacter)
	Signals.canInteract.connect(_handleCanInteractBox)
	Signals.canNotInteract.connect(_handleCanNotInteractBox)
	Signals.leftInteractArea.connect(_handleLeftInteractArea)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		twistInput = - event.relative.x * SENSITIVITY_X
		pitchInput = - event.relative.y * SENSITIVITY_Y
		rotate_y(deg_to_rad(twistInput))
		visuals.rotate_y(deg_to_rad(-twistInput))
		$CameraMount.rotate_x(pitchInput)
		$CameraMount.rotation.x = clamp($CameraMount.rotation.x, -0.5, 0.5)

func _handleSearch():
	if is_on_floor():
		if not isLocked:
			print("Searching...")
			animation_player.play("idle")
			isLocked = true
			_unlockCharacter()

func _handleInteract():
	if TextBox.visible:
		Signals.textSkip.emit()
	else:
		interact()

func _handleRun():
	SPEED = runningSpeed
	isRunning = true

func _handleJump():
	velocity.y = JUMP_VELOCITY

func _physics_process(delta):
	if Input.is_action_just_pressed("search"):
		_handleSearch()
	if Input.is_action_just_pressed("interact"):
		_handleInteract()
	if Input.is_action_pressed("run"):
		_handleRun()
	else:
		SPEED = walkingSpeed
		isRunning = false
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("menu"):
		_handlePause()

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and not isLocked:
		_handleJump()

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if !isLocked:
			if isRunning:
				if animation_player.current_animation != "running":
					animation_player.play("walking")
			else:
				if animation_player.current_animation != "walking":
					animation_player.play("running")
			visuals.look_at(position + direction)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		if !isLocked:
			if animation_player.current_animation != "idle":
				animation_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if !isLocked:
		move_and_slide()

func _unlockCharacter():
	isLocked = false

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
			isLocked = true
			currentInteractable.onInteract()
			interact_box.hide()
			interact_timer.start()

func _handlePause():
	if PauseMenu.visible:
		pass
	else:
		PauseMenu._pause()

func _on_interact_timer_timeout():
	_resetInteract()

func _on_animation_player_animation_finished(_anim_name):
	_unlockCharacter()
