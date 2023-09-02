extends Node

var saveID : String
var saveFilePath = "user://save/"
var saveFileName = "save-%s.tres"
var playerID : PlayerData
var puzzleSavedData : PuzzleList

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
	var saveNumber : String = saveFileName % id
	puzzleSavedData = ResourceLoader.load(saveFilePath + saveNumber)
	var puzzleList = PuzzleList.new()
	puzzleList._initList(puzzleSavedData)
	Signals.puzzleLoaded.emit()
	SceneSwitcher._newGame()

func _saveGame(id):
	pass
