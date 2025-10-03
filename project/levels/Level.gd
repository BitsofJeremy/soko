extends Node2D

export (PackedScene) var RedEnemy
export (PackedScene) var RedTank1
export (PackedScene) var RedTank2
export (PackedScene) var RedHelo
export (PackedScene) var Pickup

onready var items = $Items
var locks = []

func _ready():
	randomize()
	$Items.hide()
	set_camera_limits()
	var lock_id = $Obstacles.tile_set.find_tile_by_name('lock')
	for cell in $Obstacles.get_used_cells_by_id(lock_id):
		locks.append(cell)
	spawn_items()
	$BluePlayer.connect('dead', self, 'game_over')
	$BluePlayer.connect('grabbed_key', self, '_on_BluePlayer_grabbed_key')
	$BluePlayer.connect('win', self, '_on_BluePlayer_win')

func set_camera_limits():
	var map_size = $Ground.get_used_rect()
	var cell_size = $Ground.cell_size
	$BluePlayer/Camera2D.limit_left = map_size.position.x * cell_size.x
	$BluePlayer/Camera2D.limit_top = map_size.position.y * cell_size.y
	$BluePlayer/Camera2D.limit_right = map_size.end.x * cell_size.x
	$BluePlayer/Camera2D.limit_bottom = map_size.end.y * cell_size.y
	
func spawn_items():
	for cell in items.get_used_cells():
		var id = items.get_cellv(cell)
		var type = items.tile_set.tile_get_name(id)
		var pos = items.map_to_world(cell) + items.cell_size/2
		match type:
			'sp_tank1_red':
				var s = RedTank1.instance()
				s.position = pos
				s.tile_size = items.cell_size
				add_child(s)
			'sp_tank2_red':
				var s = RedTank2.instance()
				s.position = pos
				s.tile_size = items.cell_size
				add_child(s)
			'sp_helo_red':
				var s = RedHelo.instance()
				s.position = pos
				s.tile_size = items.cell_size
				add_child(s)
			'sp_soldier_red':
				var s = RedEnemy.instance()
				s.position = pos
				s.tile_size = items.cell_size
				add_child(s)
			'sp_soldier_blue':
				$BluePlayer.position = pos
				$BluePlayer.tile_size = items.cell_size
			'silver_hex', 'gold_hex', 'key', 'exit':
				var p = Pickup.instance()
				p.init(type, pos)
				add_child(p)
				p.connect('hex_pickup', $HUD, 'update_score')

func game_over():
	print("You have died")
	Global.game_over()
 
func _on_BluePlayer_win():
	print("You have won this level")
	Global.next_level()
 
func _on_BluePlayer_grabbed_key():
	for cell in locks:
		$Obstacles.set_cellv(cell, -1)
