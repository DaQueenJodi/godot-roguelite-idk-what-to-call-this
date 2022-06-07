extends TileMap


onready var _tile_set: = get_tileset()


func place_tile(location: Vector2):
	  set_cellv(location, _tile_set.find_tile_by_name("wooden_floor"))
