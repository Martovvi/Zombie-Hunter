extends AnimatedSprite
# Plays an impact animation when the bullet hits something.

func _on_Impact_animation_finished():
	queue_free()
