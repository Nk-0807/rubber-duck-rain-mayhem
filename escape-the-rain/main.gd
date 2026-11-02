extends Node2D

@export var player: CharacterBody2D
@export var spawn_point: Node2D
@export var death_screen: Control
@export var countdown_label: Label
@export var timer_label: Label  # <-- Drag your TimerLabel here in the Inspector
@export var spawner: Node2D

var is_dead: bool = false
var survival_time: float = 0.0
var game_started: bool = false

func _ready() -> void:
	# Auto-find fallbacks
	if not player: player = get_node_or_null("Player")
	if not spawn_point: spawn_point = get_node_or_null("SpawnPoint")
	if not death_screen: death_screen = get_node_or_null("CanvasLayer/DeathScreen")
	if not countdown_label: countdown_label = get_node_or_null("CountdownLabel")
	if not timer_label: timer_label = get_node_or_null("CanvasLayer/TimerLabel")
	if not spawner: spawner = get_node_or_null("spawner")
	
	if death_screen:
		death_screen.visible = false
	start_countdown()

func _process(delta: float) -> void:
	# Only count time while the game is active and player is alive
	if game_started and not is_dead:
		survival_time += delta
		if timer_label:
			# Format as seconds with 2 decimal places (e.g., "Time: 12.45s")
			timer_label.text = "Time: " + "%.2f" % survival_time

func start_countdown() -> void:
	if countdown_label:
		countdown_label.text = "3"
		countdown_label.visible = true
	await get_tree().create_timer(1.0).timeout
	
	if countdown_label:
		countdown_label.text = "2"
	await get_tree().create_timer(1.0).timeout
	
	if countdown_label:
		countdown_label.text = "1"
	await get_tree().create_timer(1.0).timeout
	
	if countdown_label:
		countdown_label.text = "GO!"
	if spawner and spawner.has_method("start_spawning"):
		spawner.start_spawning()
		
	game_started = true # Start the survival timer!
	await get_tree().create_timer(0.5).timeout
	
	if countdown_label:
		countdown_label.visible = false

func player_died() -> void:
	if is_dead:
		return
	is_dead = true
	game_started = false # Pause timer during death screen
	
	if player:
		player.visible = false
		player.set_physics_process(false)
	
	if death_screen:
		death_screen.visible = true
	
	# Optional: Print final survived time to the output console or display on screen
	print("You survived for: ", "%.2f" % survival_time, " seconds!")
	
	for i in range(3, 0, -1):
		if countdown_label:
			countdown_label.text = "Survived: " + ("%.2f" % survival_time) + "s\nRespawning in " + str(i) + "..."
			countdown_label.visible = true
		await get_tree().create_timer(1.0).timeout
	
	if death_screen:
		death_screen.visible = false
	if countdown_label:
		countdown_label.visible = false
	
	# Reset survival timer for the next run
	survival_time = 0.0
	
	if spawn_point and player:
		player.global_position = spawn_point.global_position
		player.velocity = Vector2.ZERO
	
	if player:
		player.visible = true
		player.set_physics_process(true)
	
	is_dead = false
	game_started = true # Resume timer
