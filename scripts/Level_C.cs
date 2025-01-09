using CatShooter.scripts;
using Godot;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;

public partial class Level_C : Node2D
{
	
	[Export]
	private int height; //Height of the level
	[Export]
	private int width; //width of the level
	[Export]
	private int iterations; //Number of times the walker will walk
	[Export]
	private int max_tiles; // max number of tiles the walker can place per iteration
	private TileMapLayer map_layer;
	private int[,] tile_map; // used to hold positions of placed tiles
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
	}

	private void generateLevel(){
		for (int i = 0; i < iterations; i++){
			walker.walk(tile_map, 6);
		}
		celluar_automata();
	}

	private void place_player()
	{
		Random rand = new Random();
		List<Vector2I> floor_tiles = get_floor_tiles();
		player.Position = floor_tiles.ElementAt(rand.Next(0, floor_tiles.Count));
	}
	private List<Vector2I> get_floor_tiles()
	{
		List<Vector2I> floor_tiles = new List<Vector2I>();
		floor_tiles.Concat(TileGetter.GetTiles(map_layer, new Vector2I(0, 8)));
        floor_tiles.Concat(TileGetter.GetTiles(map_layer, new Vector2I(1, 8)));
        floor_tiles.Concat(TileGetter.GetTiles(map_layer, new Vector2I(0, 9)));
        floor_tiles.Concat(TileGetter.GetTiles(map_layer, new Vector2I(1, 9)));

        return floor_tiles;
	}
	private void draw_map(){
		for (int x = 0; x < width; x++){
			for (int  y= 0; y < height; y++){
				if (tile_map[x, y] == 1){
					// Need to place a wall tile for some reason to get the best results
					map_layer.SetCell(new Vector2I(x, y), tile_set_id, new Vector2I(0, 0));
				}
			}
		}
		//Adds walls to the placed tiles 
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
