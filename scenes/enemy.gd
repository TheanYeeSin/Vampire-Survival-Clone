extends CharacterBody2D

signal enemy_defeated

var player

const SPEED = 50
var health = 5

const DISAPPEAR_SCENE = preload("res://scenes/disappear.tscn")

func _ready():
	player = get_node("/root/Game/Player")
	%AnimatedSprite2D.play("run")
	
func _physics_process(delta):
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * SPEED
		move_and_slide()
		
func take_damage():
	%AnimatedSprite2D.play("hit")
	health -= 1
	if health <= 0:
		queue_free()
		var disappear_scene = DISAPPEAR_SCENE.instantiate()
		get_parent().call_deferred("add_child", disappear_scene)
		disappear_scene.global_position = global_position
		enemy_defeated.emit()
		
func _on_animated_sprite_2d_animation_finished():
	# If the hit animation ends, switch back to run
	%AnimatedSprite2D.play("run")
