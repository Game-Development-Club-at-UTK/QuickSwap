extends Node3D

#variables that we grab from the gun script
var lifetime: int
var is_hitscan: bool
var projectile_speed: int

#variable that we grab from the player
var spawnPoint = Vector3(0,0,0)
var targetPoint = Vector3(0,0,0)
#variables we calculate for this script
var initialVelocity = Vector3(0,0,0)
var currentVelocity = Vector3(0,0,0)
var gravity = 10
var isHitboxActive = true

func _ready():
	#pull data off the chip #eventually this will copy all the data on the chip
	is_hitscan = $"..".currentChip.is_hitscan
	lifetime = $"..".currentChip.lifetime
	projectile_speed = $"..".currentChip.projectile_speed
	
	
	#pull data off the player
	spawnPoint = $"/root/base/player".current_projectile_spawn_point
	targetPoint = $"/root/base/player".current_target_point
	
	self.global_position = spawnPoint
	
	#process hitscans in the ready function. else, grab velocity values
	if is_hitscan:
		#rotate entire scene towards the enemy
		self.look_at_from_position(spawnPoint, targetPoint)
		
		$GPUParticles3D.emitting = true
		
		#draw mesh from vectors
		$MeshInstance3D.mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
		$MeshInstance3D.mesh.surface_set_color("f27c00")
		$MeshInstance3D.mesh.surface_add_vertex(Vector3(0,-.04,0))
		$MeshInstance3D.mesh.surface_add_vertex(Vector3(0,-.04,-20))
		$MeshInstance3D.mesh.surface_add_vertex(Vector3(0,.04,0))
		$MeshInstance3D.mesh.surface_add_vertex(Vector3(0,.04,-20))
		$MeshInstance3D.mesh.surface_end()
		
		$MeshInstance3D2.mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
		$MeshInstance3D2.mesh.surface_set_color("9a5c0f")
		$MeshInstance3D2.mesh.surface_add_vertex(Vector3(.05,-.08,0))
		$MeshInstance3D2.mesh.surface_add_vertex(Vector3(.05,-.08,-20))
		$MeshInstance3D2.mesh.surface_add_vertex(Vector3(.05,.08,0))
		$MeshInstance3D2.mesh.surface_add_vertex(Vector3(.05,.08,-20))
		$MeshInstance3D2.mesh.surface_end()
		
		
		$RayCast3D.force_raycast_update()
		if $RayCast3D.is_colliding():
			$RayCast3D.get_collider()._hit(1,0,Vector3(0,0,0))
	else: #if we're not a hitscan, get velocity values
		initialVelocity = (targetPoint - spawnPoint).normalized() * projectile_speed
		currentVelocity = initialVelocity

func _process(delta):
	
	
	lifetime -= 1
	if lifetime == 0:
		self.queue_free()
	
	if is_hitscan == false:
		currentVelocity.y -= gravity * delta
		self.global_position += currentVelocity * delta #update projectile position
		
		if isHitboxActive:
			if $Area3D.has_overlapping_bodies(): 
				for body in $Area3D.get_overlapping_bodies():
					body._hit(2,0,Vector3(0,0,0))
					isHitboxActive = false
					$Area3D.free()
					$GPUParticles3D2.emitting = true
					$GPUParticles3D2.top_level = true
			if $RayCast3D.is_colliding():
				isHitboxActive = false
				$GPUParticles3D2.emitting = true
				$GPUParticles3D2.top_level = true
		
		
	else:
		if lifetime == 20:
			$MeshInstance3D2.visible = false
		if lifetime == 12:
			$MeshInstance3D.visible = false
