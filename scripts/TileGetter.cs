using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CatShooter.scripts
{
    public static class TileGetter
    {
        public static List<Vector2I> GetTiles(TileMapLayer tile_layer, Vector2I atlas_location)
        {
            List<Vector2I> tiles = tile_layer.GetUsedCellsById(tile_layer.TileSet.GetNextSourceId(), atlas_location).ToList();
            return tiles;
        }
    }
}
