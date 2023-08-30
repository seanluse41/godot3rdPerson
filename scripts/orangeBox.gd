extends Interactable
@onready var collision_shape_3d = $StaticBody3D/CollisionShape3D

@export var puzzleResource: Resource
@export var testText: String
var inPuzzle : bool = false

func _ready():
	if get_tree().current_scene.scene_file_path == puzzleResource.path:
		inPuzzle = true
	else:
		inPuzzle = false
	var loadedResource = await puzzleResource._loadData()
	if loadedResource == null:
		pass
	else:
		puzzleResource = loadedResource
		if puzzleResource.solved:
			collision_shape_3d.disabled = false
		else:
			collision_shape_3d.disabled = true

func onInteract():
	if puzzleResource.solved and not inPuzzle:
		Signals.textStarted.emit(testText)
		await Signals.textFinished
		_interactionFinished()
	else:
		_interactionStart(func(): orangeBox())

func orangeBox():
	if inPuzzle:
		_solve()
		puzzleResource._exitPuzzle()
		_interactionFinished()
	else:
		await puzzleResource._enterPuzzle()
		_interactionFinished()

func _on_area_3d_body_entered(_body):
	canInteract = false
	_canInteract(self)

func _on_area_3d_body_exited(_body):
	_leftInteractArea()

func _solve():
	puzzleResource._puzzleSolved(puzzleResource)
