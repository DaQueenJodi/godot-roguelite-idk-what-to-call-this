extends Node2D

const NUM_OF_STEPS = 300 # how many steps the walker will take, the bigger the number the bigger the map
const Player = preload("res://src/Actors/Player.tscn")
const ExitDoor = preload("res://src/Objects/ExitDoor.tscn")
const BasicEnemy = preload("res://src/Actors/BasicEnemy.tscn")

var borders = Rect2(1, 1, 38, 21) # 2 tile border in a 38 x 21 grid (minus the border)

onready var inside_tiles = $Navigation2D/InsideTiles # path
onready var outside_tiles = $OutsideTiles # outside

onready var nav = $Navigation2D


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
	
	# spawn enemy in random tile
	for i in range(4):
		var basic_enemy = BasicEnemy.instance()
		add_child(basic_enemy)
		basic_enemy.nav = nav
		basic_enemy.player = player
		basic_enemy.position = map[rand_range(0, len(map))] * 32
	
	
	
	walker.queue_free()
	
	for location in map:
		outside_tiles.set_cellv(location, -1) # erase the tile
	outside_tiles.update_bitmask_region(borders.position, borders.end)

func reload():
	get_tree().reload_current_scene()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		reload()
