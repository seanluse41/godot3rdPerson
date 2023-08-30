extends Resource
class_name PuzzleList
@export var puzzleList : Array[Puzzle]

func _savePuzzles():
	Gamedata._verifySaveDirectory()
	Gamedata._savePuzzleData(self)

func _loadPuzzles():
	GlobalPuzzleList.PuzzleList = Gamedata._loadPuzzleData()
	Signals.puzzleLoaded.emit()

func _getPuzzleResource(id):
	return GlobalPuzzleList.PuzzleList.puzzleList[id]
