extends CharacterBody2D

signal health_depleted

const SPEED = 200
const DAMAGE_RATE = 5.0

const DISAPPEAR_SCENE = preload("res://scenes/disappear.tscn")
var health = 100.0

func _physics_process(delta):
	var direction = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	velocity = direction * SPEED
	move_and_slide()
	
	if velocity.length() > 0.0:
		if (velocity.x < 0):
			%AnimatedSprite2D.flip_h = true
		elif (velocity.x > 0):
			%AnimatedSprite2D.flip_h = false
		%AnimatedSprite2D.play("run")
	else:
		%AnimatedSprite2D.play("idle")
	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	
	if overlapping_mobs.size() > 0:
		health -= overlapping_mobs.size() * DAMAGE_RATE * delta
		%ProgressBar.value = health
		%ProgressBar.visible = true
		
		if health <= 0.0:
			queue_free()
			var disappear_scene = DISAPPEAR_SCENE.instantiate()
			get_parent().add_child(disappear_scene)
			disappear_scene.global_position = global_position
			health_depleted.emit()
			
			
	
