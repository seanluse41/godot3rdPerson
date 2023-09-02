extends Resource
class_name PlayerData

@export var id: String
@export var name: String
@export var puzzlesSolved : int
@export var inventory : Array[Resource]
@export var currentMap : String

func _getPlayerID():
	return id

func _getPuzzlesSolved():
	return puzzlesSolved

func _checkInventory():
	pass

func _getCurrentMap():
	return currentMap
