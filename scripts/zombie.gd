extends KinematicBody2D
# Simple zombie AI that follows the player and kills him when the player is too close.

const MOVE_SPEED = 155

var velocity = Vector2.ZERO

onready var raycast = $RayCast2D
onready var zombie_body = $Body
onready var zombie_legs = $Legs
onready var blood = load("res://scenes/blood.tscn")

func chase_player(delta):
	var player = get_tree().get_root().get_node("Game").get_node("Player")
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	global_rotation = atan2(vec_to_player.y, vec_to_player.x)
	move_and_collide(vec_to_player * MOVE_SPEED * delta)
		
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "Player":
			coll.kill()

# Animations controller for various zombie based animations.
func animations_controller():
	if(velocity != Vector2.ZERO):
		zombie_body.play("default")
		zombie_legs.play("default")
	if(velocity != Vector2.ZERO):
		zombie_legs.play("default")
	if(velocity == Vector2.ZERO):
		zombie_legs.stop()
		zombie_legs.play("idle")
	elif(velocity == Vector2.ZERO):
		zombie_body.play("idle")
		zombie_legs.play("idle")

 # Rotates legs based on movement direction.
func rotate_legs():
	if(velocity.x != 0 && velocity.y == 0):
		if(velocity.x > 0):
			zombie_legs.set_rotation_degrees(-90)
		else:
			zombie_legs.set_rotation_degrees(90)
	elif(velocity.x == 0 && velocity.y != 0):
		if(velocity.y > 0):
			zombie_legs.set_rotation_degrees(0)
		else:
			zombie_legs.set_rotation_degrees(180)
	elif(velocity.x != 0 && velocity.y != 0):
		if(velocity.x > 0 && velocity.y < 0):
			zombie_legs.set_rotation_degrees(-135)
		elif(velocity.x < 0 && velocity.y > 0):
			zombie_legs.set_rotation_degrees(45)
		elif(velocity.x > 0 && velocity.y > 0):
			zombie_legs.set_rotation_degrees(-45)
		elif(velocity.x < 0 && velocity.y < 0):
			zombie_legs.set_rotation_degrees(135)
	else:
		zombie_legs.set_rotation_degrees(0)


func _physics_process(delta):
	chase_player(delta)


func hit():
	var blood_instance = blood.instance()
	get_tree().current_scene.add_child(blood_instance)
	blood_instance.global_position = global_position
	var player = get_tree().get_root().get_node("Game").get_node("Player")
	blood_instance.rotation = global_position.angle_to_point(player.global_position)
	queue_free()
