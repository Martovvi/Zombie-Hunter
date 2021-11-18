extends Node
# Global script for closing the game with ESCAPE.

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)

# Called at every frame as fast as possible.
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func play_sound(sound):
	pass
