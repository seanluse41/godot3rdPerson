extends Node

var saveID : String
var saveFilePath = "user://save/"
var saveFileName = "save.tres"
var puzzleSavedData : Resource

func _newGame():
	_verifySaveDirectory()
	PuzzleList.new()
	SceneSwitcher._newGame()

func _verifySaveDirectory():
	DirAccess.make_dir_absolute(saveFilePath)
	Signals.saveDataDirectoryOK.emit()

func _savePuzzleData(puzzleResource):
	ResourceSaver.save(puzzleResource, saveFilePath + saveFileName, ResourceSaver.FLAG_BUNDLE_RESOURCES)
	Signals.puzzleSaved.emit()

func _loadPuzzleData():
	if FileAccess.file_exists(saveFilePath + saveFileName):
		puzzleSavedData = ResourceLoader.load(saveFilePath + saveFileName)
		Signals.puzzleLoaded.emit()
		return puzzleSavedData
	else:
		return null

func _loadSave(id):
	pass

func _saveGame(id):
	pass
