extends Node3D

@export var SegmentCount = 10

@onready var parent = $".." as Node3D
@onready var globalValues = get_node("/root/GlobalValues")
@onready var portalCount = globalValues.PortalFrequency

var segmentClass = preload("res://Components/Segment.tscn")
var segments : Array[Segment] = []

func _process(delta):
	if segments.size() == 0:
		InitializeSegments()		
	
func InitializeSegments():
	for i in range(SegmentCount):
		var segment = segmentClass.instantiate() as Segment
		var point = Vector3.ZERO
		if i > 0:
			point = segments[segments.size() - 1].nextPoint.global_position		
		segment.HasPortal = HasPortal()
		segment.PlayerExited.connect(ExitSegment)
		segments.append(segment)		
		parent.add_child(segment)		
		segment.global_position = point

func ExitSegment(exitedSegment : Segment):
	var segment = segmentClass.instantiate() as Segment
	var point = segments[segments.size() - 1].nextPoint.global_position
	segment.HasPortal = HasPortal()
	segment.PlayerExited.connect(ExitSegment)
	segments.append(segment)		
	parent.add_child(segment)		
	segment.global_position = point
	segments.remove_at(0)
	exitedSegment.queue_free()

func HasPortal() -> bool:
	portalCount -= 1
	if portalCount <= 0:
		portalCount = globalValues.PortalFrequency
		return true
	return false
	
