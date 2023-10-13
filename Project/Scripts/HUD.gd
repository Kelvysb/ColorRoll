extends CanvasLayer
class_name HUD

@onready var lifes = $Control/LifesBox/Lifes as Label
@onready var multiplier = $Control/ScoreBox/Multiplier as Label
@onready var score = $Control/ScoreBox/Score as Label
@onready var level = $Control/LevelBox/Level as Label
@onready var time = $Control/LevelBox/Time as Label

func SetScore(value : int):
	score.text = str(value)
	
func SetLives(value : int):
	lifes.text = str(value)
	
func SetTime(value : int):
	time.text = str(value)
	
func SetLevel(value : int):
	level.text = str(value)
	
func SetMultiplier(value : int):
	multiplier.text = str(value)
