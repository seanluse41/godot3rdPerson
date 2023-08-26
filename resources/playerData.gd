extends Resource
class_name PlayerData

@export var id: int
@export var name: String
@export var puzzlesSolved : int
@export var inventory : Array[Resource]

func _getPlayerID():
	return id

func _getPuzzlesSolved():
	return puzzlesSolved

func _checkInventory():
	pass
