extends KinematicBody2D

export var FRICTION = 10
export var ACCELERATION = 100
export var MAX_SPEED = 80

var velocity = Vector2.ZERO
var collide = Vector2.ZERO


func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	collide = move_and_collide(velocity)
	if collide:
		velocity = velocity.bounce(collide.normal)
