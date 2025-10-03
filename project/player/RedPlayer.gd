extends 'res://player/Player.gd'

signal moved
signal dead
signal grabbed_key
signal win

func _process(delta):
	if can_move:
		for dir in moves.keys():
			if Input.is_action_pressed(dir):
				if move(dir):
					emit_signal("moved")


func _on_RedPlayer_area_entered(area):
	if area.is_in_group('enemies'):
		print("died")
		emit_signal('dead')
	if area.has_method('pickup'):
		print("Picked up something")
		area.pickup()
	if area.type == 'key':
		print("Got the key")
		emit_signal('grabbed_key')
	if area.type == 'exit':
		print("Reached Exit")
		emit_signal('win')
