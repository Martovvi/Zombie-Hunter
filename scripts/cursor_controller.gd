extends Node2D
# A custom animated cursor.

# Hides default cursor on start.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass

# Called at every frame as fast as possible.
func _process(delta):
	position = get_global_mouse_position() # Updates mouse position
	pass
