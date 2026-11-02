extends RigidBody2D

@export var lifespan: float = 6.0 # Seconds before the duck disappears
var life_timer: float = 0.0

# Preload your explosion scene
var explosion_scene = preload("res://Explosion.tscn")

func _ready() -> void:
	# Give the duck a random starting angle and a fun random spin speed
	rotation = randf_range(0.0, PI * 2.0)
	angular_velocity = randf_range(-8.0, 8.0)

func _physics_process(delta: float) -> void:
	# Clean up old ducks over time to prevent lag
	life_timer += delta
	if life_timer > lifespan:
		queue_free()

# Triggered when colliding with another physics body (like the player)
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D or body.is_in_group("player"):
		# Disable duck collision immediately so it doesn't trigger again
		if has_node("CollisionShape2D"):
			$CollisionShape2D.set_deferred("disabled", true)
		visible = false
		
		# 1. Spawn the explosion animation at the player's current position
		if explosion_scene:
			var explosion = explosion_scene.instantiate()
			explosion.global_position = body.global_position
			get_tree().current_scene.add_child(explosion)
		
		# 2. Trigger the death screen and countdown in Main.gd
		var main_node = get_tree().current_scene
		if main_node.has_method("player_died"):
			main_node.player_died()
		
		# 3. Destroy the duck
		queue_free()
	else:
		queue_free()
