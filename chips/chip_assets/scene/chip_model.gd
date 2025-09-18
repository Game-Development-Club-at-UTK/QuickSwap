@tool
extends Node3D
class_name ChipMesh

@onready var model_normal : MeshInstance3D = $model_normal
@onready var model_t : MeshInstance3D = $model_t
@onready var model_curved : MeshInstance3D = $model_curved
@onready var model_jagged : MeshInstance3D = $model_spike
@onready var symbol : Sprite3D = $Symbol


@export var chip_model_resource : ChipModel:
	set(new_resource):
		if chip_model_resource != null:
			chip_model_resource.changed.disconnect(_model_setup)
		chip_model_resource = new_resource
		chip_model_resource.changed.connect(_model_setup)


func _ready() -> void:
	_model_setup()

func _model_setup() -> void:
	model_normal.hide()
	model_curved.hide()
	model_jagged.hide()
	model_t.hide()
	if chip_model_resource != null:
		symbol.show()
		symbol.texture = chip_model_resource.symbol_png
		symbol.modulate = chip_model_resource.symbol_color
		if chip_model_resource.chip_model == 0:
			model_normal.show()
			var material : StandardMaterial3D = model_normal.get_active_material(0)
			material.albedo_color = chip_model_resource.chip_color
		elif chip_model_resource.chip_model == 1:
			model_curved.show()
			var material : StandardMaterial3D = model_curved.get_active_material(0)
			material.albedo_color = chip_model_resource.chip_color
		elif chip_model_resource.chip_model == 2:
			model_t.show()
			var material : StandardMaterial3D = model_t.get_active_material(0)
			material.albedo_color = chip_model_resource.chip_color
		elif chip_model_resource.chip_model == 3:
			model_jagged.show()
			var material : StandardMaterial3D = model_jagged.get_active_material(0)
			material.albedo_color = chip_model_resource.chip_color
	else:
		symbol.hide()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		pass
