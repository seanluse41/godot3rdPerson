extends Interactable

@export var orangeBoxPuzzle: String
@export var solved: bool = false
@export var puzzleID: int = 1

func onInteract():
	_interactionStart(func(): orangeBox())

func orangeBox():
	await SceneSwitcher.switchScene(orangeBoxPuzzle)
	_interactionFinished()
	_solve()

func _on_area_3d_body_entered(_body):
	canInteract = false
	_canInteract(self)

func _on_area_3d_body_exited(_body):
	_leftInteractArea()

func _solve():
	Puzzles._puzzleSolved(puzzleID)
	solved = true
