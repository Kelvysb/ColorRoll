extends CanvasLayer

@onready var globalValues = get_node("/root/GlobalValues")
@onready var clickSound = $ClickSound
@onready var restart = $Control/VBoxContainer/Restart
@onready var timeLabel = $HBoxContainer/Time
@onready var scoreLabel = $HBoxContainer/Score

var focused = false

func _physics_process(delta):
	if not focused:
		restart.grab_focus()
		focused = true

func _on_restart_pressed():
	clickSound.play()	
	globalValues.PortalFrequency = 2
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Stages/main.tscn")

func _on_quit_pressed():
	clickSound.play()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/MainMenu.tscn")

func SetScore(time : int, score: int):
	timeLabel.text = str(time)
	scoreLabel.text = str(score)

func PlayClick():
	if focused:
		clickSound.play()
