extends Control

@onready var main = $MarginContainer/Main
@onready var load_screen = $MarginContainer/LoadScreen
@onready var options_screen = $MarginContainer/OptionsScreen
@onready var save_1 = $MarginContainer/LoadScreen/MarginContainer/HBoxContainer/MarginContainer/save1
@onready var save_2 = $MarginContainer/LoadScreen/MarginContainer/HBoxContainer/MarginContainer2/save2
@onready var save_3 = $MarginContainer/LoadScreen/MarginContainer/HBoxContainer/MarginContainer3/save3
var saveFilePath = "user://save/"
var save1FileName = "save-1.tres"
var save2FileName = "save-2.tres"
var save3FileName = "save-3.tres"

var currentScreen : Control = main

func _ready():
	if FileAccess.file_exists(saveFilePath + save1FileName):
		save_1.disabled = false
	if FileAccess.file_exists(saveFilePath + save2FileName):
		save_2.disabled = false
	if FileAccess.file_exists(saveFilePath + save3FileName):
		save_3.disabled = false

func _on_start_button_up():
	Gamedata._newGame()

func _on_load_button_up():
	main.hide()
	load_screen.show()
	currentScreen = load_screen

func _on_options_button_up():
	main.hide()
	options_screen.show()
	currentScreen = options_screen

func _on_quit_button_up():
	get_tree().quit()

func _on_back_button_pressed():
	if currentScreen == load_screen:
		load_screen.hide()
	elif currentScreen == options_screen:
		options_screen.hide()
	main.show()

func _on_save_1_pressed():
	Gamedata._loadSave("1")
func _on_save_2_pressed():
	Gamedata._loadSave("2")
func _on_save_3_pressed():
	Gamedata._loadSave("3")
