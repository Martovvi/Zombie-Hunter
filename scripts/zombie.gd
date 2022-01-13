extends KinematicBody2D
# Simple zombie AI that follows the player and kills him when the player is too close.

const MOVE_SPEED = 130

var is_chasing = false

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
	is_chasing = true
		
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "Player":
			coll.kill()

func animations_controller():
	if(is_chasing):
		zombie_body.play("default")
		zombie_legs.play("default")
	else:
		zombie_body.stop()
		zombie_legs.stop()
		zombie_body.play("idle")
		zombie_legs.play("idle")

func _physics_process(delta):
	chase_player(delta)
	animations_controller()

func hit():
	var blood_instance = blood.instance()
	get_tree().current_scene.add_child(blood_instance)
	blood_instance.global_position = global_position
	var player = get_tree().get_root().get_node("Game").get_node("Player")
	blood_instance.rotation = global_position.angle_to_point(player.global_position)
	queue_free()
