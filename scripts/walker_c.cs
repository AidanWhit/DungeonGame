using Godot;
using System;
using System.Collections.Generic;
using System.Linq;

public partial class walker_c{
    private int x_pos;
    private int y_pos;
    private  int max_tiles = 10;
    Random rand = new Random();
    private int map_width;
    private int map_height;
    private Godot.Vector2[] directions = {new Godot.Vector2(0, 1), new Godot.Vector2(1, 0), new Godot.Vector2(-1, 0), new Godot.Vector2(0, -1)};
    private Godot.Vector2 current_direction = new Godot.Vector2(1, 0);
    private int tiles_added = 0;
    private int[,] tile_map;
    private HashSet<Godot.Vector2I> filled_tiles;
    public walker_c(Godot.Vector2 starting_position, int [,] tile_map, HashSet<Godot.Vector2I> filled_tiles, int max_tiles){
        x_pos = (int)starting_position.X;
        y_pos = (int)starting_position.Y;
        this.tile_map = tile_map;
        this.filled_tiles = filled_tiles;
        map_width = tile_map.GetLength(0);
        map_height = tile_map.GetLength(1);

        this.max_tiles = max_tiles;

    }
    private void add_cell_large_square(int x_pos, int y_pos, int length){
        for (int dx = -length/2; dx < length/2; dx++){
            for (int dy = -length/2; dy < length / 2; dy++){
                if (x_pos + dx >= 0 && x_pos + dx < map_width && y_pos + dy >= 0 && y_pos + dy< map_height){
                    tile_map[x_pos + dx, y_pos + dy] = 1;
                    filled_tiles.Add(new Godot.Vector2I(x_pos + dx, y_pos + dy));
                }
            }
        }
    }
    public void walk(int[,] tile_map){
        tiles_added = 0;
        while (tiles_added < max_tiles){
            if (tile_map[x_pos, y_pos] == 0){
                add_cell_large_square(x_pos, y_pos, 6);
                tiles_added++;
            }
            changeDirection(filled_tiles);
        }
    }
    private void changeDirection(HashSet<Godot.Vector2I> filled_tiles){
        int rand_int = (int)rand.NextInt64();
        if (rand_int % 2 == 0){
            // Godot.Vector2 original_direction = current_direction;
            // while(original_direction.Equals(current_direction)){
            //     current_direction = directions[rand.Next(0, 4)];
            // }
            // current_direction = directions[rand.Next(0, 4)];
            current_direction = new Vector2I(rand.Next(-1, 2), rand.Next(-1, 2));
        }

        x_pos += (int)current_direction.X;
        y_pos += (int)current_direction.Y;

        if (x_pos > map_width - 1 || x_pos < 0 || y_pos > map_height - 1 || y_pos < 0){
            Godot.Vector2I new_location = filled_tiles.ElementAt(rand.Next(0, filled_tiles.Count));
            x_pos = new_location.X;
            y_pos = new_location.Y;
        }

    }
}