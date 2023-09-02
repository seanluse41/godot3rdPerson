extends PuzzleList
class_name Puzzle
@export var id: int
@export var name: String
@export var solved: bool
@export var type: String
@export var path: String
@export var returnPath: String

var loadedPuzzleData

func _puzzleSolved(puzzleResource):
	puzzleResource.solved = true
	_savePuzzles()

func _getPuzzleStatus():
	return self.solved

func _getPuzzlePath():
	return self.path

func _loadData():
	loadedPuzzleData = await _getPuzzleResource(self.id)
	return loadedPuzzleData

func _enterPuzzle():
	await SceneSwitcher.switchScene(path)

func _exitPuzzle():
	SceneSwitcher.switchScene(returnPath)
