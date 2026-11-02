extends Area2D

const SPEED = 350.0

func _process(delta: float) -> void:
	position.y += SPEED * delta
	if position.y > 700:
		queue_free()

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		get_tree().reload_current_scene()
