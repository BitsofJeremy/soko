extends Control

func _input(event):
	if event.is_action_pressed('ui_select'):
		Global.new_game()

func _on_Timer_timeout():
	get_tree().change_scene(Global.start_screen)

func _on_CoffinDance_finished():
	get_tree().change_scene(Global.start_screen)
