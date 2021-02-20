extends Node2D


const Player = preload("res://Game/Beer.tscn")
const Goal = preload("res://Game/Goal.tscn")
onready var rng = RandomNumberGenerator.new()
onready var tileMapUsedCells = $TileMap.get_used_cells()

func _ready():
	rng.randomize()
	generatePlayer(tileMapUsedCells[1])
	generateGoal()
	var goalNode = self.get_node("Goal")
	print(goalNode.get_tree())
	goalNode.connect("goalAreaEntered",self,"resetGoal")

func resetGoal():
	print("patata XDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD")

func generateGoal():
	var handUpOrDown = rng.randi_range(1,2)
	var goalPos = rng.randi_range(10,27)
	var goal_instance = Goal.instance()
	add_child(goal_instance)
	if handUpOrDown == 1:
		goal_instance.position = $TileMap.map_to_world(Vector2(goalPos,tileMapUsedCells[0].y))
	else:
		goal_instance.position = $TileMap.map_to_world(Vector2(goalPos, (tileMapUsedCells[tileMapUsedCells.size() - 1].y + 1) ))
		goal_instance.rotation_degrees += 180

func generatePlayer(position):
	var player_instance = Player.instance()
	add_child(player_instance)
	player_instance.position = $TileMap.map_to_world(position + Vector2(0,2)) 
	
