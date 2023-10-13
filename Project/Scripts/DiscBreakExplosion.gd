extends Node3D
class_name DiscBreakExplosion

@export var color : Color = Color.BLACK

@onready var gpu_particles_3d = $GPUParticles3D
@onready var lifeTime = 5.0

func _ready():
	gpu_particles_3d.draw_pass_1.get_material().albedo_color = color
	gpu_particles_3d.draw_pass_1.get_material().emission = color

func _process(delta):
	lifeTime -= delta
	if lifeTime <=0:
		queue_free()
	if not gpu_particles_3d.emitting:
		gpu_particles_3d.emitting = true
