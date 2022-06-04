extends KinematicBody

const MOVE_SPEED = 10
const JUMP_FORCE = 25
const GRAVITY = 0.98
const MAX_FALL_SPEED = 25

const H_LOOK_SENS = 0.5
const V_LOOK_SENS = 0.5

onready var cam = $CamBase
onready var anim = $Graphics/AnimationPlayer

var y_velo = 0

func _ready():
	anim.get_animation("walk").set_loop(true)
	
func _input(event):
	if event is InputEventMouseMotion:
		cam.rotation_degrees.x -= event.relative.y * V_LOOK_SENS
		cam.rotation_degrees.x = clamp(cam.rotation_degrees.x, -15, 15)
		rotation_degrees.y -= event.relative.x * H_LOOK_SENS

func _physics_process(delta):
	var move_vec = Vector3()
	if Input.is_action_pressed("move_forwards"):
		move_vec.z -= 1
	if Input.is_action_pressed("move_backwards"):
		move_vec.z += 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
		
	move_vec = move_vec.normalized()
	move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)
	move_vec *= MOVE_SPEED
	move_vec.y = y_velo
	move_and_slide(move_vec, Vector3(0, 1, 0))
	
	var grounded = is_on_floor()
	y_velo -= GRAVITY
	var just_jumped = false
	if grounded and Input.is_action_pressed("jump"):
		just_jumped = true
		y_velo = JUMP_FORCE
	if grounded and y_velo <= 0:
		y_velo = -0.1
	if y_velo < -MAX_FALL_SPEED:
		y_velo = -MAX_FALL_SPEED
		
	if just_jumped:
		play_anim("jump")
	elif grounded:
		if move_vec.x == 0 and move_vec.z == 0:
			play_anim("idle")
		else:
			play_anim("walk")

func play_anim(name):
	if anim.current_animation == name:
		return
	anim.play(name)
	
		
		
	
	
		
	
	
