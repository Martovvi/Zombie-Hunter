extends RigidBody2D
# Bullets appear in front of the gun when shooting.

onready var impact = preload("res://scenes/guns/bulletimpact.tscn")

func _on_Bullet_body_entered(body):
	if !body.is_in_group("player"):
		var impact_instance = impact.instance()
		impact_instance.position = get_global_position()
		get_tree().get_root().add_child(impact_instance)
		queue_free()
