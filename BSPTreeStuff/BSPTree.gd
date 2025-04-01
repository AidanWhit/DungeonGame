extends Node2D

var root_node : Branch
var rooms : Array = []
var paths : Array = []
@export var tile_size : int = 16
@export var map_size : Vector2i
@onready var tile_set : TileMapLayer = $"TileMapLayer"

@onready var player := $"PlayerRefactor"
func _ready() -> void:
	root_node = Branch.new(Vector2i(10, 10), map_size)
	root_node.split(4, paths)
	
	var tile_set_id = tile_set.tile_set.get_source_id(0)
	
	for path in paths:
		# Horizontal connection
		if (path['left'].y == path['right'].y):
			var y = path['left'].y
			#Create a 3 tile long path conneting the two centers
			for x in range(path['right'].x - path['left'].x):
				tile_set.set_cell(Vector2i(path['left'].x + x, y), tile_set_id, Vector2i(0, 0))
				tile_set.set_cell(Vector2i(path['left'].x + x, y + 1), tile_set_id, Vector2i(0, 0))
				tile_set.set_cell(Vector2i(path['left'].x + x, y + 2), tile_set_id, Vector2i(0, 0))
		elif(path['left'].x == path['right'].x):
			var x = path['left'].x
			var y = path['left'].y
			#Create a 3 tile long path conneting the two centers
			for i in range(path['right'].y - path['left'].y):
				tile_set.set_cell(Vector2i(x, y + i), tile_set_id, Vector2i(0, 0))
				tile_set.set_cell(Vector2i(x - 1, y + i), tile_set_id, Vector2i(0, 0))
				tile_set.set_cell(Vector2i(x + 1, y + i), tile_set_id, Vector2i(0, 0))
				tile_set.set_cell(Vector2i(x + 2, y + i), tile_set_id, Vector2i(0, 0))
	
	for leaf in root_node.get_leaves():
		# Generate padding for each room
		var padding = Vector4i(
			randi_range(1, 2),
			randi_range(2, 3),
			randi_range(1, 2),
			randi_range(2, 3)
		)
		# add room sizes to a list of rooms
		# will possibly be used to know how to decorate rooms/place enemies
		add_room(padding, leaf)
		for x in range(leaf.size.x):
			for y in range(leaf.size.y):
				if not within_padding(padding, x, y, leaf.size):
					tile_set.set_cell(Vector2i(leaf.position.x + x, leaf.position.y + y), tile_set_id, Vector2i(0, 0))
	
	cellular_automata.new(tile_set)
	
	tile_set.set_cells_terrain_connect(tile_set.get_used_cells(), 0, 0, false);
	
	'''
	Below all of this is stuff for testing enemies and such
	'''
	#spawn a boid for testing. Make sure to remove
	var floor_tiles : Array = tile_set.get_used_cells_by_id(tile_set_id, Vector2i(0, 8))
	
	#var boid_scene : PackedScene = preload("res://scenes/boid.tscn")
	#for i in range(0, 5):
		#var obj = boid_scene.instantiate()
		#obj.position = floor_tiles[randi() % floor_tiles.size()] * 16
		#
		#get_tree().root.add_child.call_deferred(obj)
	#
	player.position = floor_tiles[randi() % floor_tiles.size()] * 16
	queue_redraw()

func add_room(padding : Vector4i, leaf: Branch) -> void:
	var start_x = leaf.position.x + padding.x
	var start_y = leaf.position.y + padding.y
	var width = leaf.size.x - padding.x - padding.z
	var height = leaf.size.y - padding.y - padding.w 
	
	rooms.append(Rect2(start_x, start_y, width, height))
func within_padding(padding : Vector4i, x: int, y: int, size : Vector2i) -> bool:
	return x < padding.x or x >= size.x - padding.z or y < padding.y or y >= size.y - padding.w

func _draw() -> void:
	#Draws the green border displaying the tree
	for leaf in root_node.get_leaves():
		draw_rect(
			Rect2(
				leaf.position.x * tile_size, # X pos
				leaf.position.y * tile_size, # Y pos
				leaf.size.x * tile_size, # width
				leaf.size.y * tile_size # height
			),
			Color.GREEN,
			false # is filled
		)
