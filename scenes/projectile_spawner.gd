extends Area2D

const PROJECTILE = preload("res://scenes/projectile.tscn")

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)
		
func shoot():
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.global_position = %SpawningPoint.global_position
	new_projectile.global_rotation = %SpawningPoint.global_rotation
	%SpawningPoint.add_child(new_projectile)
	
func _on_timer_timeout():
	shoot()
