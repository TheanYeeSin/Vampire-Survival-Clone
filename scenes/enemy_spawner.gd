extends Path2D




func spawn_enemy():
	const ENEMY = preload("res://scenes/enemy.tscn")
	var new_enemy = ENEMY.instantiate()
	
	%PathFollow2D.progress_ratio = randf()
	
	new_enemy.global_position = %PathFollow2D.global_position
	
	var main_scene = get_tree().root.get_node("Game")
	new_enemy.enemy_defeated.connect(main_scene._on_enemy_defeated)
	
	get_parent().get_parent().add_child(new_enemy)


func _on_timer_timeout():
	spawn_enemy()
