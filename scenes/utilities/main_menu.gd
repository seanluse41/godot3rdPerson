extends Control

@onready var main = $MarginContainer/Main
@onready var load_screen = $MarginContainer/LoadScreen
@onready var options_screen = $MarginContainer/OptionsScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_start_button_up():
	Gamedata._newGame()

func _on_load_button_up():
	main.hide()
	load_screen.show()

func _on_options_button_up():
	pass # Replace with function body.


func _on_quit_button_up():
	get_tree().quit()


func _on_back_button_pressed():
	load_screen.hide()
	main.show()

func _on_save_1_pressed():
	pass # Replace with function body.


func _on_save_2_pressed():
	pass # Replace with function body.


func _on_save_3_pressed():
	pass # Replace with function body.
