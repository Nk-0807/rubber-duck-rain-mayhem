extends AnimatedSprite2D

func _ready() -> void:
	# Play the explosion animation immediately
	play("explode")
	
	# Connect to the animation_finished signal to delete itself when done
	animation_finished.connect(_on_animation_finished)

func _on_animation_finished() -> void:
	queue_free()
