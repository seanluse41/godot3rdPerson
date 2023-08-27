extends Node

@onready var playerData : PlayerData

var saveID
var saveFilePath = "user://save/"
var saveFileName = "save-%s.tres" % [saveID]
var puzzleSavedData : Resource

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
