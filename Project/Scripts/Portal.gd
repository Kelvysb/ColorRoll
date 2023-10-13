extends Node3D
class_name Portal

@export var PortalColor : Color = Color.BLACK
@onready var circle = $Circle
@onready var breakParticles = preload("res://Components/DiscBreakExplosion.tscn")
@onready var portalParticles = $GPUParticles3D as GPUParticles3D

func _ready():
	SetColor(PortalColor)
	
func SetColor(color : Color):
	PortalColor = color
	circle.set_instance_shader_parameter("PortalColor", PortalColor)
	portalParticles.set_instance_shader_parameter("color", PortalColor)	

func Break():
	var particles = breakParticles.instantiate() as DiscBreakExplosion
	particles.color = PortalColor
	var root =  get_tree().get_current_scene()
	root.add_child(particles)
	particles.global_position = circle.global_position	
	portalParticles.queue_free()
	circle.queue_free()

func HandlePlayerContact(player : Player):
	if visible:
		if player.GetColor() != PortalColor:
			player.Damage(1)
		else:
			player.SetPoints(10)
		Break()


func _on_portal_contact_area_area_entered(area):
	if area.is_in_group("player"):
		HandlePlayerContact(area.get_parent() as Player)
