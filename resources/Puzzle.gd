extends Resource

class_name Puzzle

@export var id: int
@export var name: String
@export var solved: bool
@export var type: String
@export var path: String

func _puzzleSolved():
	self.solved = true
	Signals.puzzleUpdated.emit()

func _getPuzzleStatus():
	return self.solved

func _getPuzzlePath():
	return self.path
