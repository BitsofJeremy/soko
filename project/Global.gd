extends Node

var levels = [
	'res://levels/Level_00.tscn', 
	'res://levels/Level_01.tscn', 
	'res://levels/Level_02.tscn',
	'res://levels/Level_03.tscn'
	]
var current_level
var score = 0
var highscore = 0
var score_file = "user://highscore.txt"
var start_screen = 'res://ui/StartScreen.tscn'
var end_screen = 'res://ui/EndScreen.tscn'
var win_screen = 'res://ui/WinScreen.tscn'

func setup():
	var f = File.new()
	if f.file_exists(score_file):
		f.open(score_file, File.READ)
		var content =  f.get_as_text()
		highscore = int(content)
		f.close()

func save_score():
	var f = File.new()
	f.open(score_file, File.WRITE)
	f.store_string(str(highscore))
	f.close()

func _ready():
	# Figure out where the save file goes?
	#var user_dir = OS.get_user_data_dir()
	#print(user_dir)
	setup()
	
func new_game():
	score = 0
	current_level = -1
	next_level()

func game_over():
	print('GAME OVER MAN!')
	if score > highscore:
		highscore = score
		save_score()
	get_tree().change_scene(end_screen)

func next_level():
	print(current_level)
	current_level += 1
	if current_level >= Global.levels.size():
		get_tree().change_scene(win_screen)
	else:
		get_tree().change_scene(levels[current_level])
