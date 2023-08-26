extends Resource

class_name Puzzle

@export var id: int
@export var name: String
@export var solved: bool
@export var type: String
@export var path: String
@export var returnPath: String
@export var audioTrack: AudioStreamMP3

var puzzleSavedData

func _puzzleSolved(puzzleResource):
	puzzleResource.solved = true
	_savePuzzleData(puzzleResource)

func _getPuzzleStatus():
	return self.solved

func _getPuzzlePath():
	return self.path

func _savePuzzleData(puzzleResource):
	Gamedata._verifySaveDirectory()
	Gamedata._savePuzzleData(puzzleResource)

func _loadData():
	puzzleSavedData = Gamedata._loadPuzzleData()
	Signals.puzzleLoaded.emit()
	return puzzleSavedData

func _setMusic():
	GlobalAudio._playAudio(audioTrack)

func _enterPuzzle():
	await SceneSwitcher.switchScene(path)
	GlobalAudio._playAudio(audioTrack)

func _exitPuzzle():
	SceneSwitcher.switchScene(returnPath)
