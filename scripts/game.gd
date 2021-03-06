extends Node
# Global script for closing the game with ESCAPE.

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)

# Called at every frame as fast as possible.
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/menu.tscn")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
