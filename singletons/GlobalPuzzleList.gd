extends Node

@export var PuzzleList : PuzzleList

func _setList(list) -> void:
	print(list)
	PuzzleList.puzzleList = list
