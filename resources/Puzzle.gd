extends Resource

class_name Puzzle

@export var id: int
@export var name: String
@export var solved: bool
@export var type: String
@export var path: String
@export var returnPath: String

var saveFilePath = "user://save/"
var saveFileName = "save.tres"

var test

func _puzzleSolved(puzzleResource):
	puzzleResource.solved = true
	_saveData(puzzleResource)

func _getPuzzleStatus():
	return self.solved

func _getPuzzlePath():
	return self.path

func _saveData(puzzleResource):
	ResourceSaver.save(puzzleResource, saveFilePath + saveFileName)
	Signals.puzzleSaved.emit()

func _loadData():
	print(self)
	test = ResourceLoader.load(saveFilePath + saveFileName)
	print("test var")
	print(test)
	return test
