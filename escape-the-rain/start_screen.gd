extends Control

@onready var start_button: Button = $Button # Make sure this matches your button node name

func _ready() -> void:
	# Connect the button's pressed signal to our function
	start_button.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed() -> void:
	# Switch to your main gameplay scene (make sure path matches your main scene file name)
	get_tree().change_scene_to_file("res://Main.tscn")
