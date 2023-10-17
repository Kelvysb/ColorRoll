extends CanvasLayer

@onready var clickSound = $ClickSound
@onready var continueButton = $Control/VBoxContainer/Continue
var focused = false

func _physics_process(delta):
	if not focused:
		continueButton.grab_focus()
		focused = true

func _on_continue_pressed():
	clickSound.play()
	get_tree().paused = false
	visible = false
	focused = false

func _on_quit_pressed():
	clickSound.play()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/MainMenu.tscn")

func PlayClick():
	if focused:
		clickSound.play()
