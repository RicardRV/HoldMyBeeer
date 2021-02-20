extends Area2D

signal goalColision

func _on_Goal_body_entered(body):
	emit_signal("goalColision")
	queue_free()
