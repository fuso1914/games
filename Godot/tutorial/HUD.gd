extends CanvasLayer

signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout") #２秒間表示する
	$MessageLabel.text = "Dodge the\nCreeps!" #/nは改行
	$MessageLabel.show()
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	
	
func update_score(score):
	$ScoreLabel.text = str(score) #ScoreLableのtextを文字列のスコアに変える
		
func _on_MessageTimer_timeout():
	$MessageLabel.hide()
		
func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
