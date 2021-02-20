extends Area2D

signal goalAreaEntered


func _on_Goal_area_entered(area):
	emit_signal("goalAreaEntered")

