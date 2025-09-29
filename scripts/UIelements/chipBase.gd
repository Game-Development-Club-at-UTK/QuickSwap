extends Sprite2D

#stores per chip data - this displays in the inventory
#think of this as the UI element that we slot into guns
@export var is_hitscan = false #if this is hitscan or a projectile
@export var projectile_speed = 0
@export var projectile_inaccuracy = 0
@export var has_special_behaviors = false #if there is nonstandard projectile physics (bounce, reflects)
@export var special_behavior_type = 0 #into for specific type of behaviors
@export var mana_cost = 0
@export var base_damage = 0
@export var cast_delay_modifier = 0
@export var recharge_delay_modifier = 0
@export var lifetime = 30

@export var chip_name: String
@export var projectile_scene: PackedScene
