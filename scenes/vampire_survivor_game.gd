extends Node2D

var score = 0

func _ready():
	get_tree().paused = false


func _on_player_health_depleted():
	get_tree().paused = true
	%GameOver.visible = true


func _on_play_button_pressed():
	get_tree().reload_current_scene()


func _on_enemy_defeated():
	score += 1
	%ScoreLabel.text = "Score: " + str(score)
