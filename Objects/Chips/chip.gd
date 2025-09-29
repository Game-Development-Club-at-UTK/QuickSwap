extends Resource
class_name Chip


@export var model : ChipModel
@export_enum("Projectile", "Projectile Modifier", "End Effect", "Weapon Modifier", "Player Modifier") var chip_type : int

@export_category("Projectile Base")
@export var damage : float
@export var num_projectiles : int
