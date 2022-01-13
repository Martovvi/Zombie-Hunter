extends Sprite

var new_color : Color

func _ready() -> void:
	randomize()
	modulate = (Color(randf(), randf(), randf(), 1.0))
	new_color = Color(randf(), randf(), randf(), 1.0)

func _process(_delta: float) -> void:
	modulate = lerp(modulate, new_color, 0.01)

func _on_Timer_timeout():
	new_color = Color(randf(), randf(), randf(), 1.0)
