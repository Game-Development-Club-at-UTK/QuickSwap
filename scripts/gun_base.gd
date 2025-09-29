extends Node3D

#this needs to handle noita style sequential projectiles.
#we have a few key things to manage - what projectile is spawned, and when to spawn it.

#listed stats - cast delay(time after every shot), recharge time(time after all shots)
#total mana(pool to draw firing costs), mana recharge rate(time to fill that pool)
#capacity - number of spell slots, accuracy - obvious #also projectile speed multiplier, which is hidden

@export var shot_capacity = 0
@export var cast_delay = 0
@export var recharge_time = 0
@export var total_mana = 0
@export var mana_recharge_rate = 0
@export var base_inaccuracy = 0
@export var projectile_speed_modifier = 0

@export var model = 0 #corresponds to what type of spell this is
@export var grip_length = 0.0 #length from origin where no slots are visible when editing
@export var slot_area_length = 0.0 #length from the end of grip_length where slots are visible

var is_in_editing_mode = false
@export var chip_slot_scene: PackedScene #reference to the chip slot scene

var currentChip #reference to the node of the next chip to be fired. must be set when we instantiate a projectile
var currentChipSlot #reference to the chip slot on this gun that we're checking

func _ready(): #in this function we could subtly randomize many of the guns properties
	#place 3d nodes at regular intervals along the gun for use as positions of UI elements
	#using camera.unproject position to get the position of a 3d node in 2d space
	for i in shot_capacity:
		$slots.add_child(Node3D.new())
		$slots.get_child(-1).add_child(chip_slot_scene.instantiate()) #add new node3d. get_child(-1) just refrences the last child added
		$slots.get_child(-1).position.z -= ((slot_area_length / shot_capacity) * i ) + grip_length

func _process(_delta):
	if is_in_editing_mode:
		for slot in $slots.get_children():
			slot.get_child(0).global_position = $"/root/EnemyTest/player/camera".unproject_position(slot.global_position) + Vector2(-40,-40)

	#basic shooting
	if Input.is_action_just_pressed("m1"): #when we input
		if not is_in_editing_mode: #as long as we're not editing
			currentChipSlot = $slots.get_child(0).get_child(0) #grab the first slot
			if not currentChipSlot.isEmpty:
				currentChip = currentChipSlot.get_child(0)
				add_child(currentChip.projectile_scene.instantiate())

#signals that the inventory is open or closed, whether to display slots
func _open_inventory():
	is_in_editing_mode = true
	for slot in $slots.get_children():
		slot.get_child(0).visible = true
func _close_inventory():
	is_in_editing_mode = false
	for slot in $slots.get_children():
		slot.get_child(0).visible = false
