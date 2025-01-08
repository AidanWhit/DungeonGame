extends Node

class_name walker

var locally_added_tiles
var tiles = 0
const max_tiles = 50
var current_direction = Vector2(1, 0)
var directions = [Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0), Vector2(0, -1)]
var current_position : Vector2
var drawn_tiles : Dictionary

const WIDTH = 25
const HEIGHT = 25

func create(max_walkers: int, position : Vector2, tile_map : TileMapLayer, current_walkers : int, added_tiles : Dictionary) -> void:
	#randomize()
	drawn_tiles = added_tiles
	current_position = position
	var tile_set_source = tile_map.tile_set.get_source_id(0)
	while(true):
		tiles += 1
		if (!drawn_tiles.has(current_position)):
			
			#tile_map.set_cell(current_position, tile_set_source, Vector2i(1, 1))
			add_to_dict(current_position)
			if (randi() % 25 == 0):
				pass
				#create_box(tile_map)
			
		change_direction()
		
		if (tiles > max_tiles):
			print("finished execution")
			break
		var spawn_walker = randi() % 2
		if (spawn_walker == 0 and current_walkers < max_walkers):
			var new_walker = walker.new()
			#new_walker.create(max_walkers, current_position, tile_map, current_walkers + 1, drawn_tiles)
			current_walkers += 1

func create_box(tile_map : TileMapLayer) -> void:
	var source_id = tile_map.tile_set.get_source_id(0)
	#tile_map.set_cell(current_position + Vector2(1, 0), source_id, Vector2i(1, 1))
	#tile_map.set_cell(current_position + Vector2(-1, 0), source_id, Vector2i(1, 1))
	#tile_map.set_cell(current_position + Vector2(0, 1), source_id, Vector2i(1, 1))
	#tile_map.set_cell(current_position + Vector2(0, -1), source_id, Vector2i(1, 1))
	
	add_to_dict(current_position + Vector2(1, 0))
	add_to_dict(current_position + Vector2(-1, 0))
	add_to_dict(current_position + Vector2(0, 1))
	add_to_dict(current_position + Vector2(0, -1))
	
	#tile_map.set_cell(current_position + Vector2(1, 1), source_id, Vector2i(1, 1))
	#tile_map.set_cell(current_position + Vector2(1, -1), source_id, Vector2i(1, 1))
	#tile_map.set_cell(current_position + Vector2(-1, 1), source_id, Vector2i(1, 1))
	#tile_map.set_cell(current_position + Vector2(-1, -1), source_id, Vector2i(1, 1))
	
	add_to_dict(current_position + Vector2(1, 1))
	add_to_dict(current_position + Vector2(1, -1))
	add_to_dict(current_position + Vector2(-1, 1))
	add_to_dict(current_position + Vector2(-1, -1))
	
func add_to_dict(tile : Vector2) -> void:
	if (!drawn_tiles.has(tile)):
		drawn_tiles.get_or_add(tile, null)
func change_direction() -> void:
	var rand_int = randi() % 2
	if (rand_int % 2 == 0):
		current_direction = directions[randi() % 4]
		
	current_position += current_direction
	if (current_position.x > WIDTH or current_position.x < 0 or current_position.y > HEIGHT or current_position.y < 0):
		current_position = drawn_tiles.keys()[randi() % drawn_tiles.size()]
		
