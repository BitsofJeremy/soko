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
					$Footsteps.play()
					emit_signal("moved")

func _on_BluePlayer_area_entered(area):
	if area.is_in_group('enemies'):
		area.hide()
		set_process(false)
		$CollisionShape2D.disabled = true
		$WilhelmScream.play()
		$AnimationPlayer.play("die")
		yield($AnimationPlayer, 'animation_finished')
		emit_signal('dead')
	if area.has_method('pickup'):
		print("Picked up something")
		area.pickup()
		if area.type == 'key':
			print("Got the key")
			emit_signal('grabbed_key')
		if area.type == 'exit':
			$Win.play()
			$CollisionShape2D.disabled = true
			print("Reached Exit")
			yield($Win, "finished")
			emit_signal('win')
