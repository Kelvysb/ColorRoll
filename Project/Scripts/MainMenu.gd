extends Node3D

@onready var globalValues = get_node("/root/GlobalValues")
@onready var start = $MainMenuUI/Control/VBoxContainer/Start
@onready var clickSound = $ClickSound
var loaded = false

func _ready():
	globalValues.PortalFrequency = 5
	start.grab_focus()
	loaded = true

func _on_start_pressed():
	PlayClick()
	globalValues.PortalFrequency = 2
	get_tree().change_scene_to_file("res://UI/ControlsSplash.tscn")

func _on_about_pressed():
	PlayClick()
	get_tree().change_scene_to_file("res://UI/AboutMenu.tscn")

func _on_exit_pressed():
	PlayClick()
	get_tree().quit()

func PlayClick():
	if loaded:
		clickSound.play()

