extends Sprite

var angle = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	angle += 0.5
	translate(Vector2(0, sin(deg2rad(angle))*0.05))	
	walk_ahead (delta)
	pass
	
func walk_ahead (delta):
	var ini_pos = get_position()
	var end_pos = get_parent().get_node("Player").get_position()
	var dif_pos = Vector2(end_pos.x - ini_pos.x, end_pos.y - ini_pos.y)
	if (dif_pos.x > 0):
		set_flip_h(false)
	else:
		set_flip_h(true)
	pass