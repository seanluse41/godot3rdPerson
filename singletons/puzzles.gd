extends Node

func _puzzleSolved(id):
	for puzzle in puzzles:
		if puzzle["id"] == id:
			puzzle["solved"] = true
			Signals.puzzleUpdated.emit()

func _getPuzzleStatus(id):
	for puzzle in puzzles:
		if puzzle["id"] == id:
			return puzzle["solved"]

var puzzles = [
	{
		"id": 1,
		"name": "orangeBox",
		"solved": false,
		"type": "physical",
		"path": "res://scenes/levels/puzzles/orangeBox/orangeBoxPuzzle.tscn"
	},
	{
		"id": 2,
		"name": "houseTorch",
		"solved": false,
		"type": "visual",
		"path": "res://scenes/levels/puzzles/houseTorchPuzzle/houseTorchPuzzle.tscn"
	},
]
