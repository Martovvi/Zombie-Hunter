extends KinematicBody2D
# Simple zombie AI that follows the player and kills him when the player is too close.

const MOVE_SPEED = 155

onready var raycast = $RayCast2D
onready var blood = load("res://scenes/blood.tscn")

func _physics_process(delta):
	
	var player = get_tree().get_root().get_node("Game").get_node("Player")
	
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	global_rotation = atan2(vec_to_player.y, vec_to_player.x)
	move_and_collide(vec_to_player * MOVE_SPEED * delta)
	
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "Player":
			coll.kill()

func hit():
	var blood_instance = blood.instance()
	get_tree().current_scene.add_child(blood_instance)
	blood_instance.global_position = global_position
	var player = get_tree().get_root().get_node("Game").get_node("Player")
	blood_instance.rotation = global_position.angle_to_point(player.global_position)
	queue_free()
