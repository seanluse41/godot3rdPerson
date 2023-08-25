extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_start_button_up():
	SceneSwitcher.switchScene("res://scenes/levels/field.tscn")


func _on_load_button_up():
	pass # Replace with function body.


func _on_options_button_up():
	pass # Replace with function body.


func _on_button_button_up():
	get_tree().quit()
