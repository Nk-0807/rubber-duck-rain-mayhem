extends StaticBody2D

# Your exact map dimensions
const MAP_WIDTH: float = 2200.0
const MAP_HEIGHT: float = 4400.0
const THICKNESS: float = 10.0

func _ready() -> void:
	# Left Wall
	_add_wall(Vector2(-THICKNESS / 2, MAP_HEIGHT / 2), Vector2(THICKNESS, MAP_HEIGHT + THICKNESS * 2))
	
	# Right Wall
	
	
	# Ground (Bottom)
	_add_wall(Vector2(MAP_WIDTH / 2, MAP_HEIGHT + THICKNESS / 2), Vector2(MAP_WIDTH + THICKNESS * 2, THICKNESS))
	
	# Ceiling (Top)
	_add_wall(Vector2(MAP_WIDTH / 2, -THICKNESS / 2), Vector2(MAP_WIDTH + THICKNESS * 2, THICKNESS))

func _add_wall(pos: Vector2, size: Vector2) -> void:
	var col = CollisionShape2D.new()
	var box = RectangleShape2D.new()
	box.size = size
	col.shape = box
	col.position = pos
	add_child(col)
