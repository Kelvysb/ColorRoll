extends Node3D

@onready var back = $MainMenuUI/Control/VBoxContainer/Back

func _ready():
	back.grab_focus()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://UI/MainMenu.tscn")
