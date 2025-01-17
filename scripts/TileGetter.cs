using Godot;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace CatShooter.scripts
{
	public static class TileGetter
	{
		public static List<Vector2I> GetTiles(TileMapLayer tile_layer, Vector2I atlas_location)
		{
			List<Vector2I> tiles = tile_layer.GetUsedCellsById(tile_layer.TileSet.GetSourceId(0), atlas_location).ToList();
			return tiles;
		}
	}
}
