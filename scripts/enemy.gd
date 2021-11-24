extends KinematicBody2D
# Basic Zombie AI that follows the player.

var motion = Vector2.ZERO
onready var bullet = preload("res://scenes/guns/bullet.tscn")

func _ready():
	pass


func _physics_process(delta):
	var Player = get_tree().get_root().get_node("Game").get_node("Player")
	
	position += (Player.position - position)/50
	look_at(Player.position)
	
	move_and_collide(motion)

# When hit do ...
func hit():
	queue_free()
