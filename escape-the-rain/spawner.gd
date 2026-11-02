extends Node2D

@export var spawn_interval: float = 0.3
var spawn_timer: float = 0.0
var raindrop_scene = preload("res://raindrop.tscn")

# Control whether ducks are currently spawning
var is_spawning: bool = false

func _process(delta: float) -> void:
	# Only spawn if the countdown has finished
	if not is_spawning:
		return
		
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_duck()
		spawn_timer = 0.0

func start_spawning() -> void:
	is_spawning = true

func spawn_duck() -> void:
	var camera = get_viewport().get_camera_2d()
	if not camera:
		return
		
	var duck = raindrop_scene.instantiate()
	var spawn_x = randf_range(camera.global_position.x - 640.0, camera.global_position.x + 640.0)
	var spawn_y = camera.global_position.y - 360.0 - 50.0
	
	duck.global_position = Vector2(spawn_x, spawn_y)
	get_tree().current_scene.add_child(duck)
