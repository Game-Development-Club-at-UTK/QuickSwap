@tool
extends Resource
class_name ChipModel

@export_enum("Normal", "Curved Top", "T Top", "Jagged Top") var chip_model : int:
	set(new_setting):
		chip_model = new_setting
		changed.emit()
@export_color_no_alpha var chip_color : Color:
	set(new_setting):
		chip_color = new_setting
		changed.emit()
@export var symbol_png : Texture2D:
	set(new_setting):
		symbol_png = new_setting
		changed.emit()
@export_color_no_alpha var symbol_color : Color:
	set(new_setting):
		symbol_color = new_setting
		changed.emit()

func _init() -> void:
	pass
