extends Node3D

#this script manages a series of columns that rise out of the ground according to a map

@export var mapTexture0 : Texture2D
@export var mapTexture1 : Texture2D
@export var mapTexture2 : Texture2D
@export var mapTexture3 : Texture2D
@export var mapTexture4 : Texture2D
@export var mapTexture5 : Texture2D
#@export var mapTexture6 : Texture2D
#@export var mapTexture7 : Texture2D
#@export var mapTexture8 : Texture2D
var currentMapTexture : Texture2D
var currentMapImage : Image
var mapInt = 0
var heightPos = 0.0

var isMoving = false
var timer = 0
var timeToMove = 40

func _ready():
	timer = timeToMove

func _set_map(mapIdx):
		isMoving = true
		#select map
		if mapIdx == -1:
			mapInt = randi_range(0,5)
		else:
			mapInt = mapIdx
		
		if mapInt == 0:
			currentMapTexture = mapTexture0
		elif mapInt == 1:
			currentMapTexture = mapTexture1
		elif mapInt == 2:
			currentMapTexture = mapTexture2
		elif mapInt == 3:
			currentMapTexture = mapTexture3
		elif mapInt == 4:
			currentMapTexture = mapTexture4
		elif mapInt == 5:
			currentMapTexture = mapTexture5
#		elif mapInt == 6:
#			currentMapTexture = mapTexture6
#		elif mapInt == 7:
#			currentMapTexture = mapTexture7
#		elif mapInt == 8:
#			currentMapTexture = mapTexture8
		currentMapImage = currentMapTexture.get_image()
		
		#set all heights
		for i in 24:
			for j in 24:
				heightPos = currentMapImage.get_pixel(i,j).r * 16
				self.get_child(i).get_child(j).targetHeight = heightPos
				self.get_child(i).get_child(j).isMoving = true

func _process(_delta):
	if Input.is_action_just_pressed("i"):
		_set_map(randi_range(0,5))
	#	if self.get_index() == 0:
	#		_set_map(2)
	#	else:
	#		_set_map(3)

	
	if isMoving:
		timer -= 1
		for i in 24:
			for j in 24:
				self.get_child(i).get_child(j)._target_lerp() #tell each child panel to move
		if timer <= 0:
			isMoving = false
			timer = timeToMove
			for i in 24:
				for j in 24:
					self.get_child(i).get_child(j).isMoving = false #set movement state to false so player will not check for it
					self.get_child(i).get_child(j).position.y = self.get_child(i).get_child(j).targetHeight #snap to height
