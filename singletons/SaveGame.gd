class_name SaveGameAsJSON
extends RefCounted

const SAVE_GAME_PATH := "user://save.json"

var version := 1

var player: Resource = PlayerData.new()

func save_exists() -> bool:
	return FileAccess.file_exists(SAVE_GAME_PATH)


func write_savegame() -> void:
	var file := FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	if file.get_error() != OK:
		printerr("Could not open the file. Aborting save operation.")
		return
	var data := {
		"currentMap": player.currentMap,
		"player":
		{
			"name": player.name,
			"id": player.id,
			"puzzlesSolved": player.puzzlesSolved,
		}
	}
	
	var json_string := JSON.stringify(data)
	file.store_string(json_string)

func load_savegame() -> void:
	var file := FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
	if file.get_error() != OK:
		printerr("Could not open the file. Aborting load operation.")
		return
	var content := file.get_as_text()

	var data: Dictionary = JSON.parse_string(content).result
	player = player.new()
	player.currentMap = data.currentMap
	player.name = data.player.name
	player.id = data.player.id
	player.puzzlesSolved = data.player.puzzlesSolved
