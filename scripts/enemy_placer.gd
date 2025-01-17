extends Node
class_name Placer

@export var enemy_scene : CharacterBody2D
@export var tile_map : TileMapLayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var tile_set_source = tile_map.tile_set.get_source_id(0)
	var floor_tiles : Array = tile_map.get_used_cells_by_id(tile_set_source, Vector2i(0, 8))
	
	print("number of blank floor tiles: ", floor_tiles)
