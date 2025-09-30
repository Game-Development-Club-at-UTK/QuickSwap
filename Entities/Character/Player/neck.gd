extends Node3D

@onready var camera : Camera3D = $Camera3D
@onready var body : CharacterBody3D = $".."

var sensitivity : float = 0.001 

func  _ready() -> void:
	pass
	
#func _process(delta):
#	pass
	
func _input(event) -> void:
	if event is InputEventMouse or event.is_action_pressed("openMenu"):
		if event is InputEventMouse && event is not InputEventMouseMotion && Input.mouse_mode != Input.MOUSE_MODE_CONFINED_HIDDEN:
			#print("BE GONE!")
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		elif event.is_action_pressed("openMenu"):
			#print("Welcome back!")
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			if event is InputEventMouseMotion:
				body.rotate_y(-event.relative.x * sensitivity)
				camera.rotate_x(-event.relative.y * sensitivity)
				
				camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
		
