extends Node

var saveFilePath = "user://save/"
var saveFileName = "save-%s.tres" % [Time.get_datetime_dict_from_system()]

func _ready():
	verifySaveDirectory(saveFilePath)

func verifySaveDirectory(path: String):
	DirAccess.make_dir_absolute(path)
