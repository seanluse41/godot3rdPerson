class_name SaveGameAsJSON
extends RefCounted

const SAVE_GAME_PATH := "user://save"

var version := 1

var player: Resource
var puzzle: Resource

func save_exists(id) -> bool:
	return FileAccess.file_exists(SAVE_GAME_PATH + id + ".json")

func write_savegame(player) -> void:
	if save_exists(player.id):
		pass
	else:
		var file := FileAccess.open(SAVE_GAME_PATH + player.id + ".json", FileAccess.WRITE)
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
			},
			"puzzles": []
		}
	
		var json_string := JSON.stringify(data)
		file.store_string(json_string)

func load_savegame(id) -> void:
	var file := FileAccess.open(SAVE_GAME_PATH + id + ".json", FileAccess.READ)
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
