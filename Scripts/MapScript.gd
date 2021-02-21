extends Node2D



const Obstacle = preload("res://Game/Obsctacle.tscn")
onready var rng = RandomNumberGenerator.new()
onready var tileMapUsedCells = $TileMap.get_used_cells()
onready var mapSort = $MapSort
onready var Player = $MapSort/Beer
onready var Goal = $MapSort/Goal
onready var EdgeOfTable = $MapSort/EndOfMap


func _ready():
	rng.randomize()
	Goal.connect("goalColision",self,"resetGoalPosition")
	Goal.connect("addObstacle",self,"generate_Obstacle")
	EdgeOfTable.connect("beerFall",self,"resetPlayerPosition")



func resetGoalPosition(body):
	var handUpOrDown = rng.randi_range(1,2)
	var goalPos = rng.randi_range(10,tileMapUsedCells[tileMapUsedCells.size()-1].x)
	body.rotation_degrees = 0
	if handUpOrDown == 1:
		body.position = $TileMap.map_to_world(Vector2(goalPos,tileMapUsedCells[0].y))
	else:
		body.position = $TileMap.map_to_world(Vector2(goalPos, (tileMapUsedCells[tileMapUsedCells.size() - 1].y + 1) ))
		body.rotation_degrees += 180

func generate_Obstacle(isFirst):
	var obstacle_instance = Obstacle.instance()
	var obstaclePosX = 25
	var obstaclePosY = 4
	if not isFirst:
		obstaclePosX = rng.randi_range(3,tileMapUsedCells[tileMapUsedCells.size()-1].x)
		obstaclePosY = rng.randi_range(tileMapUsedCells[0].y,tileMapUsedCells[tileMapUsedCells.size()-1].y)
	mapSort.add_child(obstacle_instance)
	obstacle_instance.position = $TileMap.map_to_world(Vector2(obstaclePosX,obstaclePosY))
	
func resetPlayerPosition(body):
	body.position = $TileMap.map_to_world(tileMapUsedCells[0] + Vector2(1,2))
	
#func generateGoal():
#	var handUpOrDown = rng.randi_range(1,2)
#	var goalPos = rng.randi_range(10,tileMapUsedCells[tileMapUsedCells.size()-1].x)
#	var goal_instance = Goal.instance()
#	mapSort.add_child(goal_instance)
#	if handUpOrDown == 1:
#		goal_instance.position = $TileMap.map_to_world(Vector2(goalPos,tileMapUsedCells[0].y))
#	else:
#		goal_instance.position = $TileMap.map_to_world(Vector2(goalPos, (tileMapUsedCells[tileMapUsedCells.size() - 1].y + 1) ))
#		goal_instance.rotation_degrees += 180
#	goal_instance.connect("goalColision",self,"resetGoalPosition")
#	goal_instance.connect("addObstacle",self,"generate_Obstacle")

#func generatePlayer(position):
#	var player_instance = Player.instance()
#	mapSort.add_child(player_instance)
#	player_instance.position = $TileMap.map_to_world(position + Vector2(0,2)) 




func _on_EndOfMap_body_entered(body):
	resetPlayerPosition(body)

