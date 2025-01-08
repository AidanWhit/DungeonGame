using Godot;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;

public partial class Level_C : Node2D
{
	[Export]
	private int height;
	[Export]
	private int width;
	[Export]
	private int iterations;
	[Export]
	private int max_tiles;
	private TileMapLayer map_layer;
	private int[,] tile_map;
	private walker_c walker;
	private HashSet<Vector2I> filled_tiles;
	private int tile_set_id;

	private CharacterBody2D player;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		tile_map = new int[width, height];
		filled_tiles = new HashSet<Godot.Vector2I>();
		walker = new walker_c(new Godot.Vector2(width/2, height/2), tile_map, filled_tiles, max_tiles);
		
		
		map_layer = GetNode<TileMapLayer>("/root/Level/TileMapLayer");
		player = GetNode<CharacterBody2D>("/root/Level/Player");
		tile_set_id = map_layer.TileSet.GetSourceId(0);
		generateLevel();

		Debug.WriteLine("Test in godot editor!");
		
	}

	private void generateLevel(){
		for (int i = 0; i < iterations; i++){
			walker.walk(tile_map);
		}
		celluar_automata();
		Random rand = new Random();
		player.Position = filled_tiles.ElementAt(rand.Next(0, map_layer.GetUsedCellsById(tile_set_id, new Vector2I(0, 8)).Count)) * 16 - new Vector2I(8, 0);
	}
	private void draw_map(){
		for (int x = 0; x < width; x++){
			for (int  y= 0; y < height; y++){
				if (tile_map[x, y] == 1){
					map_layer.SetCell(new Vector2I(x, y), tile_set_id, new Vector2I(0, 0));
				}
			}
		}
		map_layer.SetCellsTerrainConnect(map_layer.GetUsedCells(), 0, 0, false);
	}
	public override void _Process(double delta)
	{
		if (Input.IsActionJustPressed("reset")){
			for (int x = 0; x < width; x++){
				for (int y = 0; y < height; y++){
					tile_map[x, y] = 0;
				}
			}
			filled_tiles.Clear();

			map_layer.Clear();

			walker = new walker_c(new Vector2(width / 2, height / 2), tile_map, filled_tiles, max_tiles);
			generateLevel();
			for (int x = 0; x < width; x++){
				for (int y = 0; y < height; y++){
					//Debug.WriteLine("Value at x,y: " + tile_map[x,y]);
				}
			}
		}
		base._Process(delta);
	}
	private void celluar_automata(){
		int [,] new_tile_map = new int[width, height];
		for (int x = 0; x < width; x++){
			for (int y = 0; y < height; y++){
				(int, int) floors_walls = get_wall_floor_counts(tile_map, x, y);
				if (floors_walls.Item2 > 4){
					new_tile_map[x, y] = 0;
				}
				else if (floors_walls.Item2 == 5){
					new_tile_map[x, y] = 0;
				}
				else{
					new_tile_map[x,y] = 1;
				}
			}
		}
		tile_map = new_tile_map;

		draw_map();
		
	}

	private (int, int) get_wall_floor_counts(int [,] tile_map, int current_cell_x, int current_cell_y){
		List<(int, int)> neighbors = new List<(int, int)>();
		int walls = 0;
		int floors = 0;
		for (int x = -1; x <= 1; x++){
			for (int y = -1; y <= 1; y++){
				if (x == 0 && y == 0) continue;
				int loc_x = current_cell_x + x;
				int loc_y = current_cell_y + y;
				neighbors.Add((loc_x, loc_y));
				
			}
		}
		foreach ((int, int) cell in neighbors){
			
			if (cell.Item1 < 0 || cell.Item1 > width - 1 || cell.Item2 < 0 || cell.Item2 > height - 1){
				walls++;
			}
			else{
				if (tile_map[cell.Item1, cell.Item2] == 1){
					floors++;
				}
				else{
					walls++;
				}
			}
		}
		

		return (floors, walls);
	}
}
