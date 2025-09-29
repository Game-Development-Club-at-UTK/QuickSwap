extends TextureButton

#this stores data on each inventory slot, both in the inventory and on guns
var isEmpty = true

func _ready():
	if self.get_child_count() == 0:
		isEmpty = true
	else:
		isEmpty = false

#called when the button is pressed
func _on_button_down() -> void:
	$"/root/base/UI"._slot_clicked(self)
