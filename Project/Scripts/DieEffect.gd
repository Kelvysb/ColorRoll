extends Node3D

const lifetime = 5.0
@onready var lifeTimer = lifetime
@onready var gpu_particles_3d = $GPUParticles3D


func _process(delta):
	lifeTimer -= delta
	if lifeTimer <= 0:
		queue_free()
	if not gpu_particles_3d.emitting:
		gpu_particles_3d.emitting = true
