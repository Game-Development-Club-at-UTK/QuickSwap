extends Control

#user interface management script #this manages the click and drop function for inventory movement
#get signals from each button every time theyre pressed, manage the chips

#signals for whether the invontory is closed or open
func _open_inventory():
	$inventory.visible = true
func _close_inventory():
	$inventory.visible = false

var heldChip #reference to the chip itself
var isChipHeld = false #if the mouse has a chip selected
var previousSlot #reference to the parent of the held chip

func _slot_clicked(slot): #when clicking on a full slot, pick up or switch. on empty, place or nothing
	if slot.isEmpty: #if the clicked slot is empty
		if isChipHeld: 
			heldChip.get_parent().isEmpty = true
			heldChip.reparent(slot)
			heldChip.position = Vector2(0,0)
			isChipHeld = false
			slot.isEmpty = false
			print("placed")
	else: #for a full slot
		if isChipHeld: #if we are holding a chip, swap
			slot.get_child(0).reparent(heldChip.get_parent())
			heldChip.get_parent().get_child(1).position = Vector2(0,0)
			heldChip.reparent(slot)
			heldChip.position = Vector2(0,0)
			isChipHeld = false
			print("swapped")
		else: #if we're not holding a chip, pick one up
			isChipHeld = true
			heldChip = slot.get_child(0)
			print("picked up")

func _process(_delta): #update the position of the held chip every frame
	if isChipHeld:
		heldChip.global_position = get_viewport().get_mouse_position()
