class_name Player
extends KinematicBody2D
# Movement script for handling player movement and animations.
# The player can move with  WASD or arrow keys.
# Player rotation is based on the position of the cursor.

# Declarations.
const MOVE_SPEED = 165.0

var velocity = Vector2.ZERO
# Test


onready var cursor = get_node("../Cursor")
onready var body = $Body
onready var legs = $Legs

# Checks for input (W, A, S, D) and velocity for player movement.
func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	if Input.is_action_pressed("ui_down"):
		velocity.y = 1
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
	
	velocity = velocity.normalized() * MOVE_SPEED

# Animations controller for various player based animations.
func animations_controller():
	if(velocity != Vector2.ZERO):
		body.play("default")
		legs.play("default")
	else:
		body.stop()
		legs.stop()
		body.play("idle")
		legs.play("idle")

 # Rotates legs based on movement direction.
func rotate_legs():
	if(velocity.x != 0 && velocity.y == 0):
		if(velocity.x > 0):
			legs.set_rotation_degrees(-90)
		else:
			legs.set_rotation_degrees(90)
	elif(velocity.x == 0 && velocity.y != 0):
		if(velocity.y > 0):
			legs.set_rotation_degrees(0)
		else:
			legs.set_rotation_degrees(180)
	elif(velocity.x != 0 && velocity.y != 0):
		if(velocity.x > 0 && velocity.y < 0):
			legs.set_rotation_degrees(-135)
		elif(velocity.x < 0 && velocity.y > 0):
			legs.set_rotation_degrees(45)
		elif(velocity.x > 0 && velocity.y > 0):
			legs.set_rotation_degrees(-45)
		elif(velocity.x < 0 && velocity.y < 0):
			legs.set_rotation_degrees(135)
	else:
		legs.set_rotation_degrees(0)

# Frame rate is synched to the physics (constant).
func _physics_process(delta):
	get_input()
	rotate_legs()
	animations_controller()
	velocity = move_and_slide(velocity)	
	var look_vec = get_global_mouse_position() - global_position # Vector pointing to the cursor.
	global_rotation = atan2(look_vec.y, look_vec.x) # Player rotates around the cursor.
