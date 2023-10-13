extends CharacterBody3D
class_name Player

@export var SpinSpeed = 5.0
@export var Step = 45.0
@export var MovingSpeed = 40.0
@export var InitialLifes = 1

@onready var geometry = $Geometry as MeshInstance3D
@onready var faceArea = $FaceArea
@onready var life = InitialLifes
@onready var hit_point = $HitPoint
@onready var ComboData = JSON.parse_string(FileAccess.open("res://Scripts/combos.json", FileAccess.READ).get_as_text())
@onready var LevelsData = JSON.parse_string(FileAccess.open("res://Scripts/levels.json", FileAccess.READ).get_as_text())
@onready var hud = $HUD as HUD
@onready var globalValues = get_node("/root/GlobalValues")
@onready var cameraShake = $CameraShake as AnimationPlayer

var score = 0
var sequence = 0
var multiplier = 1
var timer = 0
var level = 1
var hitEffect = preload("res://Components/HitEffect.tscn")
var DieEffect = preload("res://Components/DieEffect.tscn")
var targetXAngle = 0.0
var targetZAngle = 0.0
var direction = Vector3.ZERO
var moving = false
var activeFaces : Array[Side] = []
var dead = false

func _input(event):
	HandleSpinInput()
	
func _physics_process(delta):
	hud.SetLives(life)
	HandleForwardMovement()
	HandleSpinMovement()
	move_and_slide()

func Damage(value : int):
	life -= value
	var effect = hitEffect.instantiate()
	add_child(effect)
	effect.position = hit_point.position
	multiplier = 1
	sequence = 0
	cameraShake.play("Shake")
	hud.SetMultiplier(multiplier)
	velocity.z = 0
	if life <= 0:
		Die()
	
func Die():
	MovingSpeed = 0	
	geometry.visible = false
	var effect = DieEffect.instantiate()
	add_child(effect)
	effect.position = hit_point.position
	dead = true
	
func SetPoints(points : int):
	score += (multiplier * points)
	sequence += 1
	hud.SetScore(score)
	CheckSequence()
	
func CheckSequence():
	for combo in ComboData.Combos:
		if combo.Count == sequence:
			multiplier = combo.Multiplier
			life += combo.Life
			if life > InitialLifes:
				life = InitialLifes
			hud.SetMultiplier(multiplier)
			return
	
func GetColor() -> Color:
	var result = Color.BLACK
	for side in activeFaces:
		result += side.ColorValue
	result.a = 1
	return result
	
func HandleForwardMovement():
	if not dead:
		velocity.z = lerpf(velocity.z, -MovingSpeed, 0.1) 

func HandleSpinInput():
	if not moving:
		direction = Vector3.ZERO
		targetXAngle = 0.0
		targetZAngle = 0.0
		if Input.is_action_just_pressed("dial_up"):
			direction.x = -1
			targetXAngle = Step
		if Input.is_action_just_pressed("dial_down"):
			direction.x = 1
			targetXAngle = Step
		if Input.is_action_just_pressed("dial_right"):
			direction.z = -1	
			targetZAngle = GetZSpinStep()	
		if Input.is_action_just_pressed("dial_left"):
			direction.z = 1		
			targetZAngle = GetZSpinStep()
		if direction:
			moving = true

func HandleSpinMovement():
	if moving and direction:
		if targetXAngle > 0:
			geometry.rotate_x(deg_to_rad(SpinSpeed * direction.x))
			targetXAngle -= SpinSpeed
		if targetZAngle > 0:
			geometry.rotate_z(deg_to_rad(SpinSpeed * direction.z))
			targetZAngle -= SpinSpeed
		if targetXAngle <= 0 and targetZAngle <= 0:
			targetXAngle = 0.0
			targetZAngle = 0.0
			moving = false
			CheckFacingSides()
	if activeFaces.size() == 0:
		CheckFacingSides()

func GetZSpinStep() -> float:
	if activeFaces.size() <= 1:
		return Step
	elif activeFaces.size() <= 2:
		return Step * 2
	else:
		return Step * 4

func CheckFacingSides():
	activeFaces.clear()
	var faces = faceArea.get_overlapping_areas()
	for face in faces:
		if face.is_in_group("side"):
			activeFaces.append(face)
	SetColor()
	
func SetColor():
	var color = Color.BLACK
	for face in activeFaces:
		color += face.ColorValue
	geometry.set_instance_shader_parameter("CoreColor", color)

func CheckLevel():
	for levelData in LevelsData.Levels:
		if levelData.TriggerTime == timer:
			level += 1
			MovingSpeed = levelData.Speed
			globalValues.PortalFrequency = levelData.Frequency
			hud.SetLevel(level)
			return

func _on_timer_timeout():
	timer += 1
	hud.SetTime(timer)
	CheckLevel()
	
