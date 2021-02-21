extends Area2D

signal goalColision(body)
signal addObstacle

var goalPoints = 0

func _on_Goal_body_entered(body):
	addGoalPoints()
	emit_signal("goalColision",self)
	
func addGoalPoints():
	goalPoints += 1
	print(goalPoints)
	if goalPoints % 3 == 0:
		emit_signal("addObstacle")
