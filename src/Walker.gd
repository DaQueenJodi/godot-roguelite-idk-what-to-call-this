extends Node
class_name Walker

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]
const MAX_STEPS_BEFORE_TURN = 6

var position = Vector2.ZERO # current walker position
var direction = Vector2.RIGHT # current walker direction
var borders = Rect2() # keeps track of borders
var step_hist = [] # keeps track of last steps
var steps_since_turn = 0 # used to make sure there arent any insanely long hallways

func _init(starting_pos, new_borders):
	assert(new_borders.has_point(starting_pos))
	position = starting_pos
	step_hist.append(position)
	borders = new_borders
	
func walk(steps): # returns step history
	create_room(position)
	for step in steps:
		if randf() <= 0.5 and steps_since_turn >= MAX_STEPS_BEFORE_TURN: # 25% chance to change directions
			change_direction()
		if step(): # if the step is succesful, add it to history, otherwise change direction
			step_hist.append(position)
		else:
			change_direction()
	return step_hist

func step():
	var target_pos = position + direction
	if borders.has_point(target_pos): # if position is within the borders, take a step, otherwise return false
		steps_since_turn += 1
		position = target_pos
		return true
	else:
		return false	

func change_direction():
	create_room(position)
	steps_since_turn = 0
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front() # use last direction
	
	while not borders.has_point(position + direction): # use new direction until one is valid
		direction = directions.pop_front()
		
func create_room(pos):
	var size = Vector2(rand_range(1, 4), rand_range(1, 4))
	var top_left_corner = (position - size/2).ceil()
	
	for y in size.y:
		for x in size.x:
			var new_step = top_left_corner + Vector2(x, y)
			if borders.has_point(new_step):
				step_hist.append(new_step)
				
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
