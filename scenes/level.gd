# rewrite this and walker2 in c# to utilize 2D arrays
extends Node2D
var walker_instance : walker
var added_tiles : Dictionary = {}
const width = 25
const height = 25
var tile_matrix = []
@onready var tile_map : TileMapLayer = get_node("TileMapLayer")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var walk = walker.new()
	walk.create(3, Vector2i(0, 0), tile_map, 1, tile_matrix)
	print("number of tiles: ", added_tiles.size())
	
func post_processing() -> void:
	var new_tile_array : Array
