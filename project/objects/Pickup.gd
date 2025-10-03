extends Area2D

signal hex_pickup

var textures = {
	'gold_hex': 'res://assets/images/gold_hexagon_32x32.png',
	'silver_hex': 'res://assets/images/silver_hexagon_32x32.png',
	'lock': 'res://assets/images/hex-silver-lock-32x32.png',
	'key': 'res://assets/images/hex-silver-key-32x32.png',
	'exit': 'res://assets/images/exit.png'
	}
var type

func _ready():
	$Tween.interpolate_property($Sprite, 'scale', Vector2(1, 1),
		Vector2(3, 3), 0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Sprite, 'modulate',
		Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5,
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)

func init(_type, pos):
	$Sprite.texture = load(textures[_type])
	type = _type
	position = pos

func pickup():
	match type:
		'silver_hex':
			$HexPickup.play()
			emit_signal('hex_pickup', 1)
			print('Silver Hex pickup +1')
		'gold_hex':
			$HexPickup.play()
			emit_signal('hex_pickup', 3)
			print('Gold Hex pickup +3')
		'key':
			$KeyPickup.play()
	$CollisionShape2D.disabled = true
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	queue_free()
