extends Node2D
# Camera follow script inspired by Hotline Miami.
# The camera follows the smoothly player in a set boundary.
# TODO: Fix jitter when moving cursor across player.

# Declarations
export (NodePath) var target

var damping = 12.0

# Frame rate is synched to the physics (constant).
func _physics_process(delta):
	apply_camera(delta)

func apply_camera(delta):
	var mpos = get_global_mouse_position()
	var ppos = global_position
	target = Vector2((ppos.x + mpos.x) / 2, (ppos.y + mpos.y) / 2)
	$Camera2D.global_position = lerp($Camera2D.global_position, target, delta * damping)
