extends CharacterBody3D

var timer = 0;
var health = 5
var moveSpeed = 4.5
var InputDirection = Vector2(0,0)
var mouseSensitivity = .1
var gravity = 10
var isGrounded = false
var jumpSpeed = 5
var current_projectile_spawn_point = Vector3(0,0,0) #the place all bullets should spawn
var current_target_point = Vector3(0,0,0)

var viewmodel_position_sway_factor = .2 #0 to 1 for lerping it
var viewmodel_rotation_sway_factor = .2 #(linear interpolation funtion controls how fast the gun snaps into place)

var is_inventory_open = false
var viewmodelPositionNode #node3D that holds the position of the gun, changes if the inventory is open

#charge shot that varies in speed, shrapnel floats and slows down, homing that floats then speeds up
#of course hitscans
#old monsterhunted wand styles, pitol-shotgun-dmr-standards. collect runes?
#shot types, accelerators, triggers, etc

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	viewmodelPositionNode = $camera/viewmodelBasePoint

func _process(delta): 
	
	#horizontal inputs
	InputDirection = Vector2(0,0)
	if Input.is_action_pressed("w"):
		InputDirection.y -= 1
	if Input.is_action_pressed("s"):
		InputDirection.y += 1
	if Input.is_action_pressed("a"):
		InputDirection.x -= 1
	if Input.is_action_pressed("d"):
		InputDirection.x += 1
	#this takes wasd stuff, rotates it so that w moves us the direction we're actually facing
	InputDirection = InputDirection.rotated(-self.rotation.y)
	InputDirection = InputDirection.normalized()
	velocity.x = InputDirection.x * moveSpeed
	velocity.z = InputDirection.y * moveSpeed

	#jump and gravity
#	if self.is_on_floor():
#		if Input.is_action_just_pressed("space"):
#			self.velocity.y += jumpSpeed
#	else:
#		self.velocity.y -= gravity * delta
	if Input.is_action_just_pressed("space"):
		self.velocity.y += jumpSpeed
	if self.is_on_floor():
		pass
	else:
		self.velocity.y -= gravity * delta

	#apply motion, test collision
	move_and_slide()

	#open and close the inventory, signal other scripts that the inventory is open or closed
	if Input.is_action_just_pressed("tab"):
		if is_inventory_open:
			is_inventory_open = false
			viewmodelPositionNode = $camera/viewmodelBasePoint
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			$camera/viewModel/gun_base._close_inventory()
			$"../UI"._close_inventory()
		else:
			is_inventory_open = true
			viewmodelPositionNode = $camera/viewmodelEditPoint
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			$camera/viewModel/gun_base._open_inventory()
			$"../UI"._open_inventory()

	#viewmodel sway
	$camera/viewModel.global_position = lerp($camera/viewModel.global_position, viewmodelPositionNode.global_position, viewmodel_position_sway_factor)
	$camera/viewModel.global_rotation = lerp($camera/viewModel.global_rotation, viewmodelPositionNode.global_rotation, viewmodel_rotation_sway_factor)
	

	#calculate view direction (used by guns to know what direction to shoot in)
	current_projectile_spawn_point = $camera/viewModel/projectileSpawnPoint.global_position
	if $camera/hitscanRaycast.is_colliding():
		current_target_point = $camera/hitscanRaycast.get_collision_point()
	else:
		current_target_point = $camera/lookDirectionHint.global_position
	#we could use look_at_position() to rotate the gun so it always faces the target

#TODO detect that when we collide with a moving platform, move ourselves to the end point of that platform
	for i in get_slide_collision_count():
		if get_slide_collision(i).get_collider().is_in_group("movingPlatform"):
			if get_slide_collision(i).get_collider().isMoving:
				self.position.y += .5



func _input(event):
	#mouse input handling
	if not is_inventory_open: #disable look changes when the inventory is open
		if event is InputEventMouseMotion:
			#print("Mouse Motion at: ", event.position)#
			self.rotation_degrees.y -= event.relative.x *  mouseSensitivity
			$camera.rotation_degrees.x -= event.relative.y *  mouseSensitivity
