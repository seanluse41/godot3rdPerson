extends Resource
class_name PuzzleList
@export var puzzleList : PuzzleList

func _savePuzzles():
	Gamedata._verifySaveDirectory()
	Gamedata._savePuzzleData(self)

func _loadPuzzles():
	GlobalPuzzleList.PuzzleList = Gamedata._loadPuzzleData()
	Signals.puzzleLoaded.emit()

func _getPuzzleResource(id):
	print(GlobalPuzzleList.PuzzleList.puzzleList)
	return GlobalPuzzleList.PuzzleList.puzzleList[id]

func _initList(resource: PuzzleList):
	print(resource)
	print(puzzleList)
	puzzleList = resource
	GlobalPuzzleList._setList(puzzleList)
	Signals.puzzleLoaded.emit()
