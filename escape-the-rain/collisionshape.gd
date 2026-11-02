extends CharacterBody2D

const SPEED = 250.0

# Connects to your AnimatedSprite2D node automatically
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	# Get movement direction from Arrow Keys or WASD
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	velocity = direction * SPEED
	
	# --- ANIMATION & FLIPPING LOGIC ---
	if direction != Vector2.ZERO:
		animated_sprite.play("run")
		
		# Flip sprite left or right based on movement direction
		if direction.x < 0:
			animated_sprite.flip_h = true
		elif direction.x > 0:
			animated_sprite.flip_h = false
	else:
		animated_sprite.play("idle")

	move_and_slide()
