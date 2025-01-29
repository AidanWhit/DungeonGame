extends Node
const MIN_DIST = 10

static func get_floor_tiles(tile_set: TileMapLayer, player: Player):
	var enemy_scene : PackedScene = preload("res://scenes/enemies/blue_dino.tscn")
	var tile_set_id = tile_set.tile_set.get_source_id(0)
	var floor_tiles : Array = tile_set.get_used_cells_by_id(tile_set_id, Vector2i(0, 8))
	floor_tiles.append_array(tile_set.get_used_cells_by_id(tile_set_id, Vector2i(0, 9)))
	floor_tiles.append_array(tile_set.get_used_cells_by_id(tile_set_id, Vector2i(1, 9)))
	floor_tiles.append_array(tile_set.get_used_cells_by_id(tile_set_id, Vector2i(1, 8)))
	
	var distances : Dictionary = {}
	
	var player_position : Vector2i = player.position / 16
	for cell : Vector2i in floor_tiles:
		var distance = sqrt(pow(player_position.x - cell.x, 2) + pow(player_position.y - cell.y, 2))
		distances[cell] = distance
	
	var tiles_erased = 0
	while tiles_erased < 1:
		var random_cell = floor_tiles.pick_random()
		if distances[random_cell] > MIN_DIST:
			var enemy = enemy_scene.instantiate()
			enemy.position = random_cell * 16
			tile_set.add_sibling(enemy)
			tiles_erased += 1
	
	
