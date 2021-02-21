extends Area2D

signal goalColision(body)
signal addObstacle(isFirst)

var goalPoints = 0

func _on_Goal_body_entered(body):
	goalPoints += 1
	if goalPoints == 1:
		emit_signal("addObstacle",true)
	else:
		checkToAddObstacles()
		emit_signal("goalColision",self)

	
func checkToAddObstacles():
	
	print(goalPoints)
	if goalPoints % 3 == 0:
		emit_signal("addObstacle",false)
