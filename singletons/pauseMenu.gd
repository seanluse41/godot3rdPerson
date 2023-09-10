extends ColorRect

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var confirm = $confirm
@onready var menu = $menu
@onready var load_screen = $LoadScreen
var currentMenu : String = "main"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_quit_button_button_up():
	get_tree().quit()

func _pause():
	animation_player.play("Pause")
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unPause():
	confirm.hide()
	animation_player.play("Unpause")
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	currentMenu = "main"

func _on_resume_button_pressed():
	_unPause()

func _on_save_button_button_up():
	currentMenu = "save"
	showConfirmDialogue()

func showConfirmDialogue():
	menu.hide()
	confirm.show()

func hideConfirmDialogue():
	confirm.hide()
	menu.show()

func showLoadMenu():
	menu.hide()
	load_screen.show()

func _on_load_button_button_up():
	currentMenu = "load"
	showLoadMenu()

func _saveGame():
	pass

func _loadGame():
	pass

func _on_yes_button_button_up():
	if currentMenu == "save":
		_saveGame()
	else:
		_loadGame()

func _on_no_button_button_up():
	hideConfirmDialogue()

func _on_back_button_pressed():
	load_screen.hide()
	hideConfirmDialogue()
	menu.show()
	currentMenu = "main"

func _on_save_3_pressed():
	pass # Replace with function body.

func _on_save_2_pressed():
	pass # Replace with function body.

func _on_save_1_pressed():
	pass # Replace with function body.
