extends Node2D


const Player = preload("res://Game/Beer.tscn")
const Goal = preload("res://Game/Goal.tscn")
const Obstacle = preload("res://Game/Obsctacle.tscn")
const GameManager = preload("res://Game/GameManager.tscn")
onready var rng = RandomNumberGenerator.new()
onready var tileMapUsedCells = $TileMap.get_used_cells()
onready var mapSort = $MapSort

var goalPoints = 0

func _ready():
	rng.randomize()
	generatePlayer(tileMapUsedCells[1])
	generateGoal()


func generateGoal():
	var handUpOrDown = rng.randi_range(1,2)
	var goalPos = rng.randi_range(10,tileMapUsedCells[tileMapUsedCells.size()-1].x)
	var goal_instance = Goal.instance()
	mapSort.add_child(goal_instance)
	if handUpOrDown == 1:
		goal_instance.position = $TileMap.map_to_world(Vector2(goalPos,tileMapUsedCells[0].y))
	else:
		goal_instance.position = $TileMap.map_to_world(Vector2(goalPos, (tileMapUsedCells[tileMapUsedCells.size() - 1].y + 1) ))
		goal_instance.rotation_degrees += 180
	goal_instance.connect("goalColision",self,"resetGoalPosition")
	goal_instance.connect("addObstacle",self,"generate_Obstacle")

func generatePlayer(position):
	var player_instance = Player.instance()
	mapSort.add_child(player_instance)
	player_instance.position = $TileMap.map_to_world(position + Vector2(0,2)) 

func resetGoalPosition(body):
	var handUpOrDown = rng.randi_range(1,2)
	var goalPos = rng.randi_range(10,tileMapUsedCells[tileMapUsedCells.size()-1].x)
	body.rotation_degrees = 0
	if handUpOrDown == 1:
		body.position = $TileMap.map_to_world(Vector2(goalPos,tileMapUsedCells[0].y))
	else:
		body.position = $TileMap.map_to_world(Vector2(goalPos, (tileMapUsedCells[tileMapUsedCells.size() - 1].y + 1) ))
		body.rotation_degrees += 180
	goalPoints += 1

func generate_Obstacle():
	var obstaclePosX = rng.randi_range(3,tileMapUsedCells[tileMapUsedCells.size()-1].x)
	var obstaclePosY = rng.randi_range(tileMapUsedCells[0].y,tileMapUsedCells[tileMapUsedCells.size()-1].y)
	var obstacle_instance = Obstacle.instance()
	mapSort.add_child(obstacle_instance)
	obstacle_instance.position = $TileMap.map_to_world(Vector2(obstaclePosX,obstaclePosY))


