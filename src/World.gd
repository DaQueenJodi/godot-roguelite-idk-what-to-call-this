extends Node2D

const NUM_OF_STEPS = 300 # how many steps the walker will take, the bigger the number the bigger the map
const Player = preload("res://src/Player.tscn")
const ExitDoor = preload("res://src/ExitDoor.tscn")

var borders = Rect2(1, 1, 38, 21) # 2 tile border in a 38 x 21 grid (minus the border)

onready var tile_map = $TileMap



func _ready():
	randomize() # set random seed
	generate_leve()
	
func generate_leve():
	var walker = Walker.new(Vector2(19, 11), borders) # 19, 11 are half of the grid in 'borders'
	var map = walker.walk(NUM_OF_STEPS)
	
	var player = Player.instance()
	add_child(player)
	player.position =  map.front()*32
	
	var exit_door = ExitDoor.instance()
	add_child(exit_door)
	exit_door.position =  walker.get_end_room().position*32
	
	exit_door.connect("leaving_level", self, "reload")
	
	
	walker.queue_free()
	
	for location in map:
		tile_map.set_cellv(location, -1) # erase the tile
	tile_map.update_bitmask_region(borders.position, borders.end)

func reload():
	get_tree().reload_current_scene()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		reload()
