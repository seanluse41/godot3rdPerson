extends Node

@onready var playerData : PlayerData

var saveID
var saveFilePath = "user://save/"
var saveFileName = "save-%s.tres" % [saveID]
var puzzleSavedData : Resource

func _newGame():
	_verifySaveDirectory()
	if FileAccess.file_exists(saveFilePath + saveFileName):
		DirAccess.remove_absolute(saveFilePath + saveFileName)
	SceneSwitcher._newGame()

func _verifySaveDirectory():
	DirAccess.make_dir_absolute(saveFilePath)
	Signals.saveDataDirectoryOK.emit()

func _getPuzzleData(_id):
	pass

func _savePuzzleData(puzzleResource):
	ResourceSaver.save(puzzleResource, saveFilePath + saveFileName)
	Signals.puzzleSaved.emit()

func _loadPuzzleData(puzzleID):
	puzzleSavedData = ResourceLoader.load(saveFilePath + saveFileName)
	Signals.puzzleLoaded.emit()
	return puzzleSavedData
