extends Node3D
class_name Segment

@export var HasPortal = false
var portalColor : Color
@onready var portal = $Portal as Portal
@onready var nextPoint = $NextPoint

signal PlayerExited(segment : Segment)

func _ready():
	portal.visible = HasPortal	
	portalColor = GetRandColor()
	portal.SetColor(portalColor)

func _physics_process(delta):
	portal.visible = HasPortal	

func GetRandColor() -> Color:
	var chance = randi_range(1, 100)
	if chance > 40:
		var primaryChance = randi_range(1, 3)
		if primaryChance == 1:
			return Color.RED
		elif primaryChance == 2:
			return Color.GREEN
		else:
			return Color.BLUE
	elif chance > 5:
		var secondaryChance = randi_range(1, 3)
		if secondaryChance == 1:
			return Color.YELLOW
		elif secondaryChance == 2:
			return Color(1.0,0.0,1.0,1.0)
		else:
			return Color.CYAN
	else:
		return Color.WHITE

func _on_exit_area_area_entered(area):
	if area.is_in_group("player"):
		PlayerExited.emit(self)
