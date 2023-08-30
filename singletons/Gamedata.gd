extends Node

var playerData : PlayerData = PlayerData.new()

var saveID : String
var saveFilePath = "user://save/"
var saveFileName = "save-%s.tres" % [playerData._getPlayerID()]
var puzzleSavedData : Resource

func _newGame():
	_verifySaveDirectory()
	if FileAccess.file_exists(saveFilePath + saveFileName):
		DirAccess.remove_absolute(saveFilePath + saveFileName)
	SceneSwitcher._newGame()

func _verifySaveDirectory():
	DirAccess.make_dir_absolute(saveFilePath)
	Signals.saveDataDirectoryOK.emit()

func _savePuzzleData(puzzleResource):
	ResourceSaver.save(puzzleResource, saveFilePath + saveFileName)
	Signals.puzzleSaved.emit()

func _loadPuzzleData(puzzleID):
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
