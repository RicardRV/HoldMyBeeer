extends Area2D

signal beerFall

func _on_Area2D_body_entered(body):
	emit_signal("beerFall",body)
