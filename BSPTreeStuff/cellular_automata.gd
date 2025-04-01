class_name cellular_automata

var tile_map : TileMapLayer

func _init(tile_map: TileMapLayer) -> void:
	self.tile_map = tile_map
	
	smooth_terrain()

func smooth_terrain() -> void:
	var used_cells : Array = tile_map.get_used_cells()
	var new_cells_to_draw : Array
	
	for cell in used_cells:
		var floor_tiles : int = 0
		var wall_tiles : int = 0
		#loops through possibl neighbor positions
		for x in range(-1 ,2):
			for y in range(-1, 2):
				var neighbor_cell_x = cell.x + x
				var neighbor_cell_y = cell.y + y
				if (Vector2i(neighbor_cell_x, neighbor_cell_y) != cell):
					# if the neighbor is a floor tile
					if (Vector2i(neighbor_cell_x, neighbor_cell_y) in used_cells):
						floor_tiles += 1
					else:
						wall_tiles += 1
		
		if (wall_tiles <= 4):
			new_cells_to_draw.append(cell)
	
	tile_map.clear()
	var tile_set_id = tile_map.tile_set.get_source_id(0)
	for cell in new_cells_to_draw:
		tile_map.set_cell(cell, tile_set_id, Vector2i(0, 0))
