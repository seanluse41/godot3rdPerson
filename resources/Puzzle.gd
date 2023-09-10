extends Resource
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
	SaveSystem.set_var(puzzleResource.name, puzzleResource)
	SaveSystem.save()

func _getPuzzleStatus():
	return self.solved

func _getPuzzlePath():
	return self.path
	

func _loadData(puzzleResourceName):
	var puzzle = Puzzle.new()
	loadedPuzzleData = await SaveSystem.get_var(puzzleResourceName)
	if loadedPuzzleData:
		puzzle.id = loadedPuzzleData.id
		puzzle.name = loadedPuzzleData.name
		puzzle.solved = loadedPuzzleData.solved
		puzzle.type = loadedPuzzleData.type
		puzzle.path = loadedPuzzleData.path
		puzzle.returnPath = loadedPuzzleData.returnPath
		return puzzle
	else:
		return null

func _enterPuzzle():
	await SceneSwitcher.switchScene(path)

func _exitPuzzle():
	SceneSwitcher.switchScene(returnPath)
