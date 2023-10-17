extends Node3D

@onready var timeLabel = $Menu/Control/TimeLabel
@onready var start = $Menu/Control/VBoxContainer/Start
var timer = 5

func _ready():
	start.grab_focus()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Stages/main.tscn")

func _on_timer_timeout():
	timer -= 1
	timeLabel.text = str(timer)
	if timer <= 0:
		_on_start_pressed()


