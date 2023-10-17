extends CanvasLayer
class_name HUD

@onready var lifes = [$Control/LifeBarContainer/LifesBox/Life1, $Control/LifeBarContainer/LifesBox/Life2, $Control/LifeBarContainer/LifesBox/Life3, $Control/LifeBarContainer/LifesBox/Life4, $Control/LifeBarContainer/LifesBox/Life5]
@onready var multiplier = $Control/ScoreContainer/Multiplier as Label
@onready var score = $Control/ScoreContainer/Score as Label
@onready var level = $Control/TimerContainer/Level as Label
@onready var time =  $Control/TimerContainer/Time as Label

func SetScore(value : int):
	score.text = str(value)
	
func SetLives(value : int):
	lifes[4].visible = (value >= 5)
	lifes[3].visible = (value >= 4)
	lifes[2].visible = (value >= 3)
	lifes[1].visible = (value >= 2)
	lifes[0].visible = (value >= 1)
	
func SetTime(value : int):
	time.text = str(value)
	
func SetLevel(value : int):
	level.text = str(value)
	
func SetMultiplier(value : int):
	multiplier.text = str(value)
