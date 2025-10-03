extends Control

func _ready():
	$Score.text = str(Global.highscore)

func _input(event):
	if event.is_action_pressed('ui_select'):
		Global.new_game()
