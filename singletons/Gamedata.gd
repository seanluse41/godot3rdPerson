extends Node

class_name GameData

var saveFilePath = "user://save/"
var saveFileName = "save-%s.tres" % [Time.get_datetime_dict_from_system()]

func _verifySaveDirectory(path: String):
	DirAccess.make_dir_absolute(path)

func _getPuzzleData(_id):
	pass
